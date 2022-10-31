.globl _start

.data
arr: .word -1 22 8 35 5 4 11 2 1 78
space: .string " "

.text

_start:
	la a1, arr
	li a2, 0			#lo=0
	li a3, 10			#hi=arr length
	li a4, 0			#second li for finishiing up later
	li a5, 10			#second hi for finishing up later
	addi a3, a3, -1		#hi-=1 (index scaling)
	j main

main:
	jal ra, quicksort
	
quicksort:

	blt a3, a2, peperun	#if hi<lo exit via peperun
	
	addi sp, sp, -16
	sw ra, 0(sp)
	sw s10, 4(sp)		#allocate s10 for lo
	sw s11, 8(sp)		#allocate s11 for hi
	sw s9, 12(sp)		#allocate s9 for pivot
	mv s10, a2		#s10 for lo
	mv s11, a3		#s11 for hi
	
	jal ra, partition		#partition the array
	
	slli t4, s11, 2		#get offset of arr[hi] in memory (useless)
	
	mv s9, a0			#s9 is now the pivot
	
	addi a3, s9, -1		#hi=pivot-1
	mv a2, s10		#load new lo
	jal ra, quicksort	#quicksort(arr,  lo, pivot-1)
	
	addi a2, s9, 1		#lo=pivot+1
	mv a3, s11		#load new hi
	jal ra, quicksort	#recursive call back to quicksort
	
	lw ra, 0(sp)		#reload and restore stack
	lw s10, 4(sp)
	lw s11, 8(sp)
	lw s9, 12(sp)
	addi sp, sp, 16
peperun:
	beq a2, a5, ssapjotbap
	jalr zero, 0(ra)
	
partition: 
	addi sp, sp, -12
	sw ra, 0(sp)
	sw s10, 4(sp)
	sw s11, 8(sp)
	slli t0, a3, 2		#get offset for arr[hi]
	add t0, t0, a1		#get address of arr[hi]
	lw t0, 0(t0)		#t0(pivot)<-arr[hi](t0)
	addi t2, a2,  -1		#t2(i) = low-1
	mv t6, a2			#t6(j) = low
	addi t5, a3, -1		#t5 = hi-1
	for_loop:
	bgt t6, t5, end_for_loop #if j>hi-1 then end loop
		slli t6, t6, 2	#get offset for arr[j]
		add s11, a1, t6#s11 = &arr[j]
		srli t6, t6, 2	#reset t6 to j (previously multiplied by 4 for offset)s
		lw t1, 0(s11)	#t1 = arr[j]
		bgt t1, t0, skip_if	#if arr[j]>pivot then end if
						#swap arr[i] with arr[j]
			addi t2, t2, 1	#i++
			slli t2, t2, 2	#get offset for arr[i]
			add s10, a1, t2#s10=&arr[i]
			srli t2, t2, 2	#reset t2 to i (previously muiltiplied by 4 for offset)
			lw t3, 0(s10)	#t3 = arr[i]
			sw t3, (s11)	#arr[j] = arr[i]
			sw t1, 0(s10)	#arr[i] = arr[j] (before swap)
		skip_if:
		addi t6, t6, 1	#j++
	j for_loop 		#iterate for_loop again
	end_for_loop:

	addi a0, t2, 1		#a0=i+1 (to be returned)
					#swap arr[i+1] with arr[hi]
	slli a0, a0, 2		#get offset for arr[i+1]
	add s10, a1, a0	#s10=&arr[i+1]
	slli a3, a3, 2		#get offset for arr[hi]
	add s11, a1, a3	#s11=&arr[hi]
	srli a0, a0, 2		#restore a0 to i+1 (previously muiltiplied by 4 for offset)
	srli a3, a3, 2		#restore a3 to hi (previously muiltiplied by 4 for offset)
	lw t2, 0(s10)		#t2=arr[i+1]
	lw t3, 0(s11)		#t3=arr[hi]
	sw t2, 0(s11)		#arr[hi] = arr[i+1]
	sw t3, 0(s10)		#arr[i+1] = arr[hi] (before swap)
	
	lw ra, 0(sp)
	lw s10, 4(sp)
	lw s11, 8(sp)
	addi sp, sp, 12
	jalr zero, 0(ra)		#peperun
ssapjotbap:
	j printArray
	
printSpace:
	la a0, space
	li a7, 4
	ecall
	j printArray

printArray:
	la a0, arr
	slli t1, a4, 2
	add t1, a0, t1
	lw a0, 0(t1)
	li a7, 1
	ecall
	addi, a4, a4, 1
	bne a4, a5, printSpace
