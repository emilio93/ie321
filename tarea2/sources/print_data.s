
# print_data
#
# $a0 : (A) direccion de inicio
# $a1 : (len) longitud del arreglo
print_data:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  addi $t0, $zero, 0 # contador
  addi $t4, $a1, -1 # limite superior

print_data_loop:
  bgt $t0, $t4, stop_print_data

  sll $t1, $t0, 2
  add $t2, $a0, $t1

  bne $t0, $zero, print_data_coma
  j print_data_loop2

print_data_loop2:
  add $t3, $zero, $a0
  li $v0, 1
  lw $a0, 0($t2)
  syscall
  add $a0, $zero, $t3

  addi $t0, $t0, 1

  j print_data_loop

print_data_coma:
  add $t3, $zero, $a0
  li $v0, 4
  la $a0, coma
  syscall
  add $a0, $zero, $t3
  j print_data_loop2

stop_print_data:
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra
