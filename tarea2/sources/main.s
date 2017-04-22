
#
# ejecuta el programa
main:
  la $a0, Data # se carga la direccion del arreglo en $a0
  la $a1, Length
  lw $a1, 0($a1) # se carga la longitud del arreglo en $a1
  # jal print_data # se imprime el arreglo
  # jal newline

  jal bubble_sort

  la $a0, Data # se carga la direccion del arreglo en $a0
  la $a1, Length
  lw $a1, 0($a1) # se carga la longitud del arreglo en $a1
  jal print_data # se imprime el arreglo
  jal newline

  # terminar ejecucion del progama
  li $v0, 10
  syscall
