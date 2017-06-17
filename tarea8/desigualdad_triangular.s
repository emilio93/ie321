# verifica si los 3 lados en triangulo pueden
# formar un triangulo
#
# con 3 lados a, b, c
# se necesita que se cumpla lo siguiente para
# poder formar el triangulo:
# a+b<c, b+c<a, c+a<b
#
# devuelve $v0 = 1 en caso que se pueda formar
# devuelve $v0 = 0 en caso que no se pueda formar
desigualdad_triangular:
  # carga los lados del triangulo en registros
  la $t0, triangulo
  lw $t1, 0($t0)
  lw $t2, 4($t0)
  lw $t3, 8($t0)

  # asume que no se puede formar
  addi $v0, $zero, 1

  # sumas de lados
  addu $t4, $t2, $t3
  addu $t5, $t3, $t1
  addu $t6, $t1, $t2

  # casos en que no se puede formar triangulo
  bge $t1, $t4, desigualdad_triangular_fallo
  bge $t2, $t5, desigualdad_triangular_fallo
  bge $t3, $t6, desigualdad_triangular_fallo

  # se puede formar triangulo, $v0 permanece
  # 1, y se regresa al programa
  jr $ra


  desigualdad_triangular_fallo:
    # no se puede formar triangulo, $v0 ahora es
    # 0, y se regresa al programa
    addi $v0, $zero, 0
    jr $ra
