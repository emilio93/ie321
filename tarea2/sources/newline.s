
# imprime un caracter newline
#
newline:
  add $t1, $a0, $zero # guardar
  li $v0, 4
  la $a0, texto_newline
  syscall
  add $a0, $t1, $zero # recuperar
  jr $ra
