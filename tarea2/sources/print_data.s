
# print_data
#
# imprime un arreglo
#
# $a0 : (A) direccion de inicio
# $a1 : (len) longitud del arreglo
print_data:
  addi $sp, $sp, -12
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)

  addi $t0, $zero, 0 # contador
  addi $t4, $a1, -1 # limite superior

  # para cada registro del arreglo
  print_data_loop:
    # if (i>(len-1))
    bgt $t0, $t4, stop_print_data

    # $a0 + 4 * i
    sll $t1, $t0, 2
    add $t2, $a0, $t1

    # poner coma si no es el primer item
    bne $t0, $zero, print_data_coma

    j print_data_loop2

  # imprimir el numero
  print_data_loop2:
    add $t3, $zero, $a0
    li $v0, 1
    lw $a0, 0($t2)
    syscall
    add $a0, $zero, $t3

    # i = i + 1
    addi $t0, $t0, 1

    j print_data_loop

  # imprime coma
  print_data_coma:
    add $t3, $zero, $a0
    li $v0, 4
    la $a0, coma
    syscall
    add $a0, $zero, $t3
    j print_data_loop2

  # reasigna los registros
  stop_print_data:
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    addi $sp, $sp, 12
    jr $ra
