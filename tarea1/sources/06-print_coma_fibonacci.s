
# print_coma_fibonacci
#
# imprime una coma
print_coma_fibonacci:
  add $t0, $zero, $v0
  add $t1, $zero, $a0

  add $v0, $zero, 4 # print string
  la $a0, coma # ,
  syscall

  add $v0, $t0, $zero
  add $a0, $t1, $zero

  j print_numero_fibonacci
