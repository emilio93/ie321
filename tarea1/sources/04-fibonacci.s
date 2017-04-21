
#  fibonacci
#
# inicializa el calculo de la serie de fibonacci hasta n elementos.
# $a0 : (n) numero n del numero de fibonacci f_n.
# $v0 : (f_n) numero f_n calculado.
fibonacci:
  # guardar return address en el stack pointer
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # inicializar valores de i_0, j_0, contador
  addi $a1, $zero, 1 # i_0 = 1 = f_1
  addi $a2, $zero, 0 # j_0 = 0 = f_0
  addi $a3, $zero, 0 # contador

  #iniciar loop
  j loop_fibonacci
