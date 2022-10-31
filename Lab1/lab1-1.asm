.globl _start

.data
var1: .word 15
var2: .word 19
newline:  .string "\n"

.text
_start:

	la a0, var1
	addi a7, zero, 1
	ecall
	
	#newline
	la a0, newline
	addi a7, zero, 4
	ecall
	
	la a0, var2
	addi a7, zero, 1
	ecall
	
	#newline
	la a0, newline
	addi a7, zero, 4
	ecall
	
	#increment var1
	lw s1, var1
	addi s1, s1, 1
	la t0, var1
	sw s1, 0(t0)
	
	#multiply var2 by 4
	lw s2, var2
	slli s2, s2, 2
	la t1, var2
	sw s2, 0(t1)
	
	#print var1
	lw a0, var1
	addi a7, zero, 1
	ecall
	#newline
	la a0, newline
	addi a7, zero, 4
	ecall
	#print var2
	lw a0, var2
	addi a7, zero, 1
	ecall
	#newline
	la a0, newline
	addi a7, zero, 4
	ecall
	
	#swap var1 and var2
	sw s2, 0(t0)
	sw s1, 0(t1)

	#print var1
	lw a0, var1
	addi a7, zero, 1
	ecall
	#newline
	la a0, newline
	addi a7, zero, 4
	ecall
	#print var2
	lw a0, var2
	addi a7, zero, 1
	ecall
	

	
