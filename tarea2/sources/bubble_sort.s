
# bubble_sort
#
# $a0 : (A) direccion que apunta a A
# $a1 : (len) cantidad de elementos en A
bubble_sort:
  addi $sp, $sp, -8
  sw $ra, 0($sp)
  sw $a1, 4($sp)


bSort_loop1:
  beq $a1, $zero, bSort_exit

  addi $t0, $zero, 0 # n = 0

  addi $t1, $zero, 1 # i = contador
  addi $t9, $a1, -1 # i-1
  j bSort_loop2

bSort_loop2:
  blt $t9, $t1, bSort_loop1
  addi $t2, $t1, -2
  sll $t2, $t2, 2
  add $t2, $t2, $a0 # dir
  lw $t4, 0($t2) # A[i-1]

  addi $t3, $t1, -1
  sll $t3, $t3, 2
  add $t3, $t3, $a0 # dir
  lw $t5, 0($t3) # A[i]

  blt $t4, $t5, bSort_loop2_cond
  j bSort_loop2_all

bSort_loop2_cond:
  sw $t4, 0($t3)
  sw $t5, 0($t2)
  add $t0, $zero, $t1
  j bSort_loop2_all

bSort_loop2_all:
  add $a1, $zero, $t0
  j bSort_loop2

bSort_exit:
  addi $sp, $sp, 8
  lw $ra, 0($sp)
  lw $a1, 4($sp)
