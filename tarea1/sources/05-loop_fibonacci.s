
# loop_fibonacci
#
# ejecuta una verificación para definir si se finaliza el loop
# en caso que no se finalice, se ejecuta el codigo del loop
# l_k = i_k + j_K
# j_{k+1} = i_k
# i_{k+1} = l_k
#
# ademas imprime una coma(en caso de no ser el primer numero) y el numero j_{k+1}
loop_fibonacci:
  # salir si contador > n
  bgt $a3, $a0, exit_fibonacci

  add $t0, $a1, $a2    # l = i + j
  add $a2, $a1, $zero  # j = i
  add $a1, $zero, $t0  # i = l

  # se incrementa en print_numero_fibonacci, que es llamado en cada loop

  # si no es el primero, imprimir
  bne $a3, $zero, print_coma_fibonacci

  # si es el primero, imprimir unicamente el numero
  j print_numero_fibonacci
