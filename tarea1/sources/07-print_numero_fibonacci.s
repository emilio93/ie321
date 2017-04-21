
# print_numero_fibonacci
#
# imprime el ultimo numero calculado
print_numero_fibonacci:
  addi $sp, $sp, -8
  sw $v0, 0($sp)
  sw $a0, 4($sp)

  li $v0, 1 # print int
  add $a0, $a2, $zero # se imprime j
  syscall

  lw $v0, 0($sp)
  lw $a0, 4($sp)
  addi $sp, $sp, 8

  addi $a3, $a3, 1 # incrementar contador

  j loop_fibonacci # volver a inicio del loop
