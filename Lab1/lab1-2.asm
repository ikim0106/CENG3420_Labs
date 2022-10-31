.globl _start

.data
arr: .word -1 22 8 35 5 4 11 2 1 78
space: .string " "

.text
_start:
	li a1, 0 #i
	li a2, 0 #j
	li a3, 10 #high

move: #swaps last element with 3rd element
	la a0, arr
	lw t5, 8(a0) #third element
	lw t6, 36(a0) #last element
	sw t5, 36(a0)
	sw t6, 8(a0)
	lw t5, 36(a0)
	
loop: 
	beq a2, a3, done
	slli t1, a1, 2 #get the offset of v[i] relative to v[0]
	add t1, a0, t1 #get the address of v[i]
	slli t2, a2, 2 #get the offset of v[j] relative to v[0]
	add t2, a0, t2 #get the address of v[j]
	lw t0, 0(t1) #load v[i] to t0
	lw t3, 0(t2) #load v[j] to t3
	bge t3, t5, increment_j #if the pivot element is greater than or equal to v[j], loop back
	j swap #otherwise, swap v[i] and v[j]
	
increment_j:
	addi a2, a2, 1
	j loop

swap:
	sw t3, 0(t1) #store t3 to v[i]
	sw t0, 0(t2) #store t0 to v[j]
	addi a1, a1, 1
	addi a2, a2, 1
	j loop
	
done:
	slli t1, a1, 2
	add t1, a0, t1
	lw t0, 0(t1)
	
	addi t2, a0, 36
	lw t3, 0(t2)
	
	sw t3, 0(t1)
	sw t0, 0(t2)
	
	li a1, 0
	j printArray
	
printSpace:
	la a0, space
	li a7, 4
	ecall
	j printArray

printArray:
	la a0, arr
	li a7, 1
	slli t1, a1, 2
	add t1, a0, t1
	lw a0, 0(t1)
	ecall
	addi, a1, a1, 1
	bne a1, a3, printSpace
