
# Emilio Rojas 2017

#
# Se presentan 2 metodos para calcular una potencia x^n:
# potencia: calcula la potencia recursivamente segun
#           x^-n = (1/x)^(-n)
#           x^0 = 1, x^1 = x
#           si n es par x^n = (x*x)^(n/2) [recursivo]
#           si n es impar x^n = x * (x*x)^((n-1)/2) [recursivo]
#
# potencia_iterativo: calcula la potencia multiplicando x, n veces.
#

# calcula la potencia $f0^$a0
# notese que el exponente debe ser entero
#
# recibe $f0 y $a0
#
# devuelve resultado en $f0
potencia:
  # se guardan registros
  potencia_guardar_registros:
    addiu $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    j potencia_iniciar

  # se selecciona el caso(n<0, n=0, n=1, n%2=0, n%2=1)
  potencia_iniciar:
    # caso $a0 < 0, x^n = (1/x)^(-n)
    blt $a0, $zero, potencia_caso_negativo

    # caso x^1 = x, $f0 ya tiene la respuesta
    addiu $t0, $zero, 1
    beq $a0, $t0, potencia_fin

    # caso x^0 = 1, respuesta es 1.0
    mov.s $f1, $f0 # $f1 = $f0, se guarda $f0 en $f1
    li.s $f0, 1,0
    beq $a0, $zero, potencia_fin # cuando $a0 = 0 se devuelve $f0 = 1,0
    mov.s $f0, $f1 # $f0 = $f1, se recupera $f0 de $f1

    sll $t0, $a0, 31 # 0 si es par
    # slr $t0, $t0, 31 # 1 si es impar

    beq $t0, $zero, potencia_caso_par
    bne $t0, $zero, potencia_caso_impar
    j potencia_fin # no deberia llegar aca

    # $f1^$a0 = (1/$f0)^-$a0
    potencia_caso_negativo:
      # se obtiene 1/$f0 y se guarda en $f0
      li.s $f1, 1,0
      div.s $f0, $f1, $f0 # $f0 = 1/$f0

      # se obtiene -$a0
      subu $a0, $zero, $a0 # -$a0 = 0 - $a0

      # se llama recursivamente a la funcion
      jal potencia
      # una vez finalizadas las llamadas recursivas se
      # brinca al fin de la funcion
      j potencia_fin

    # si la potencia es un numero par se puede expresar como
    # $f0^$a0 = ($f0 * $f0)^(a/2)
    potencia_caso_par:
      mul.s $f0, $f0, $f0 # $f0 = $f0 * $f0
      srl $a0, $a0, 1 # $a0/2
      jal potencia
      j potencia_fin

    # si la potencia es un numero impar se puede expresar como
    # $f0^$a0 = $f0 * ($f0 * $f0)^((a-1)/2)
    potencia_caso_impar:
      # se guarda valor $f0 en stack
      addi $sp, $sp, -4
      s.s $f0, 0($sp)

      mul.s $f0, $f0, $f0 # $f0 = $f0*$f0 = $f0^2
      addi $a0, $a0, -1 # $a0 = $a0-1
      srl $a0, $a0, 1 # $a0 = $a0/2
      jal potencia

      # se recupera valor de $f0 del stack y se guarda en $f1
      l.s $f1, 0($sp)
      addi $sp, $sp, 4

      # se multiplica para completar orden de potencia,
      # el resultado queda en $f0
      mul.s $f0, $f0, $f1
      j potencia_fin

  # restaurar registros y regresar al programa
  potencia_fin:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addiu $sp, $sp, 12
    jr $ra

# calcula la potencia x^n multiplocando x, n veces.
#
# recibe $f0 = x
# recibe $a0 = n
#
# devuelve resultado en $f0
potencia_iterativo:
  mov.s $f1, $f0
  # caso x^1 = x
  addiu $t0, $zero, 1
  beq $a0, $t0, potencia_iterativo_fin

  # caso < 0
  bge $a0, $zero, potencia_iterativo_no_negativo # si $a0 < 0
    li.s $f1, 1,0
    div.s $f0, $f1, $f0 # $f0 = 1/$f0
    subu $a0, $zero, $a0 # -$a0 = 0 - $a0
    j potencia_iterativo
  potencia_iterativo_no_negativo:

  # caso x^0 = 1
  li.s $f0, 1,0
  beq $a0, $zero, potencia_iterativo_fin

  # caso x^n = x * x * ... * x
  # recuerdese que la entrada $f0 ahora esta en $f1
  addiu $t0, $zero, 0
  li.s $f0, 1,0
  potencia_iterativo_loop:
    mul.s $f0, $f0, $f1 # $f0 = $f0' * $f1
    addiu $t0, $t0, 1
    blt $t0, $a0, potencia_iterativo_loop

  # regresa al programa
  potencia_iterativo_fin:
  jr $ra
