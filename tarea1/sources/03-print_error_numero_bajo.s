
# print_error_numero_bajo.s
#
# imprime un error indicando que el entero ingresado está fuera del
# rango permitido.
print_error_numero_bajo:
  # addi $sp, $sp, -8
  # sw $a0, 0($sp)
  # sw $v0, 4($sp)
  addi $v0, $zero, 4 # print string
  la $a0, error_numero_bajo
  syscall
  # lw $a0, 0($sp)
  # lw $v0, 4($sp)
  # addi $sp, $sp, 8
  j solicitud
