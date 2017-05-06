# Universidad de Costa Rica
# Escuela de Ingeniería Eléctrica
# Estructuras de Computadoras Digitales I - IE0321
# Tarea 3
# Emilio Javier Rojas Álvarez - B15680
#
# Se implementa el algoritmo tal cual de
# la figura 3.5 del libro de texto.
# Se utiliza aritmética de 64 bits para poder
# representar una multiplicación de dos numeros
# cuya suma de bits significativos sea mayor a
# 32
# Adicional a esto una interfaz simple para
# que el usuario realice las multiplicaciones


.text

# main
#
# metodo main se ejecuta al inicio dl programa
main:
  # etiqueta de inicio del programa
  inicio:

    # Solicita el multiplicando al usuario
    solicitar_multiplicando:
      # imprimir la solictud
      li $v0, 4 # print string
      la $a0, solicitud_multiplicando
      syscall

      # leer entrada del usuario
      addi $v0, $zero, 5 # read int
      syscall

      # guardar la entrada del usuaro en registro
      add $t0, $zero, $v0

    # Solicita el multiplicador al usuario
    solicitar_multiplicador:
      # imprimir solicitud
      li $v0, 4 # print string
      la $a0, solicitud_multiplicador
      syscall

      # leer entrada del usuario
      addi $v0, $zero, 5 # read int
      syscall

      # guardar entrada del usuario en registro
      add $t1, $zero, $v0 # guardar respuesta en $t1

    # asigna el multiplicando y multiplicador a los
    # argumentos $a0 y $a1
    asignar_variables:
      move $a0, $t0
      move $a1, $t1

    # ejecuta la multiplicacion
    llamar_multiplicar:
      jal multiplicar

    # indica la respuesta de la multiplicacion
    imprimir_respuesta:
      move $s0, $v0 # mantener en $s0 parte superior
      move $s1, $v1 # mantener en $s1 parte inferior

      li $v0, 4 # print string
      la $a0, texto_resultado
      syscall

      jal newline

      li $v0, 4 # print string
      la $a0, texto_resultado_sup
      syscall

      li $v0, 1 # print int
      move $a0, $s0
      syscall

      jal newline

      li $v0, 4 # print string
      la $a0, texto_resultado_inf
      syscall

      li $v0, 1 # print int
      move $a0, $s1
      syscall

    # permite realizar otra multiplicacion
    reiniciar:
      j inicio

    addi $v0, $zero, 10
    syscall


# Multiplica $a0 con $a1
# y guarda el resultado en $v0 $v1
#
# parametros:
#   $a0 es multiplicando
#   $a1 es multiplicador
# salidas:
#   $v0 es parte izquierda de la respuesta
#   $v1 es parte derecha de la respuesta
multiplicar:
  # guardar los registros en el stack pointer
  multiplicar_guardar_registros:
    addi $sp, $sp, -32
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $s0, 12($sp)
    sw $s1, 16($sp)
    sw $s2, 20($sp)
    sw $s3, 24($sp)
    sw $s4, 28($sp)

  # inicializa el contador, iteracion máxima
  # y valor del producto.
  multiplicar_iniciar_variables:
    li $s0, 0 # contador i
    li $s1, 31 # cantidad de iteraciones - 1
    li $v0, 0 # producto parte izquierda
    li $v1, 0 # producto parte derecha

  # obtiene el bit 0 del multiplicador y actua
  # segun lo obtenido (0 o 1)
  multiplicar_test_multiplier0:
    andi $t0, $a1, 1
    bne $t0, $zero, multiplicar_multiplier0
    beq $t0, $zero, multiplicar_not_multiplier0

  # if multiplier's bit 0 = 1
  multiplicar_multiplier0:
    # guardr argumentos
    move   $t0, $a0
    move   $t1, $a1

    # guardar en el producto la suma del
    # multiplicando y el producto
    # cargar argumentos de la suma
    addu $a2, $zero, $zero
    addu $a3, $a0, $zero

    addu $a0, $v0, $zero
    addu $a1, $v1, $zero
    jal sum64
    # restaurar argumentos
    move   $a0, $t0
    move   $a1, $t1

    j multiplicar_shift_multiplicand_left

  # if multiplier's bit 0 = 0
  multiplicar_not_multiplier0:
    j multiplicar_shift_multiplicand_left

  # rotar multiplicando a la izquierda
  multiplicar_shift_multiplicand_left:
    sll $a0, $a0, 1

  # rotar multiplicando a la derecha
  multiplicar_shift_multiplier_right:
    srl $a1, $a1, 1

  # asegurarse que se hagan las 32 iteraciones necesarias
  # y salir cuando se cumplan
  multiplicar_check_iteration:
    bgt $s0, $s1, multiplicar_restaurar_registros
    # tambien, si el multiplocador es 0, la operacion esta lista
    beq $a1, $zero, multiplicar_restaurar_registros
    addiu $s0, $s0, 1 # i++
    j multiplicar_test_multiplier0

  # restaurar los registros del stack pointer
  # y regresar al programa mediante $ra
  multiplicar_restaurar_registros:
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    lw $s0, 12($sp)
    lw $s1, 16($sp)
    lw $s2, 20($sp)
    lw $s3, 24($sp)
    lw $s4, 28($sp)
    addi $sp, $sp, 32
    jr $ra

# MINI ALU 64
# mimics a 64bits alu's operations
# - sum
# - twos complement
# - substraction
# - switch left logical
# -switch right logical

# sum64
#
# does $a0 $a1 + $a2 $a3 = $v0 $v1
sum64:
  addu $v1, $a1, $a3
  sltu $v0, $v1, $a3
  addu $v0, $v0, $a0
  addu $v0, $v0, $a2
  jr $ra

# twoscomplement64
#
# gets twos complement of $a0 $a1 in $v0 $v1
twoscomplement64:
  # negate
  li $t0, 0xffffffff
  xor $t1, $t0, $a0
  xor $t2, $t0, $a1
  # sum 1
  addiu $v1, $t2, 1
  # check carry bit
  sltiu $v0, $v1, 1
  addu $v0, $v0, $t1
  jr $ra

# sub64
#
# does $a0 $a1 - $a2 $a3 = $v0 $v1
sub64:
  # save registers in stack
  addiu $sp, $sp, -12
  sw $ra, 0($sp)
  sw $s0, 4($sp)
  sw $s1, 8($sp)

  # save arguments $a0 and $a1
  move $a0, $s0
  move $a1, $s1

  # load arguments $a0 and $a1
  # with $a2 and $a3
  move $a2, $a0
  move $a3, $a1

  # get its twos complement
  jal twoscomplement64

  # restore values to $a0 and $a1
  move $s0, $a0
  move $s1, $a1

  # sum $a0 $a1 + twoscomplement64($a2 $a3)
  jal sum64

  # restore values saved in stack
  lw $ra, 0($sp)
  lw $s0, 4($sp)
  lw $s1, 8($sp)
  addiu $sp, $sp, 12
  jr $ra

# sll64
#
# switch left logical $a0 $a1 in $v0 $v1
# also $t9 indicates overflow
sll64:
  # first check overflow, so $a0's MSB shouldn't be 1
  addiu $t9, $zero, 0
  srl $t0, $a0, 31
  beq $t0, $zero, sll64_nooverflow
  addiu $t9, $zero, 1

  # always execute, only a label to jump to if no overflow
  sll64_nooverflow:
  sll $v0, $a0, 1
  sll $v1, $a1, 1
  srl $t0, $a1, 31
  or $v0, $t0, $v0
  jr $ra

# srl64
#
# switch right logical $a0 $a1 in $v0 $v1
srl64:
  srl $v0, $a0, 1
  srl $v1, $a1, 1
  and $t0, $a0, 1
  sll $t0, $t0, 31
  or $v1, $t0, $v1
  jr $ra

# imprime un caracter newline
#
newline:
  add $t1, $zero, $a0
  add $t2, $zero, $v0
  li $v0, 4
  la $a0, texto_newline
  syscall
  add $a0, $zero, $t1
  add $v0, $zero, $t2
  jr $ra

# data
#
#datos utilizados en el programa
.data
  solicitud_multiplicando: .asciiz "\nIngrese el multiplicando:\n"
  solicitud_multiplicador: .asciiz "Ingrese el multiplicador:\n"
  texto_resultado: .asciiz "Resultado: "
  texto_resultado_sup: .asciiz "Parte superior(decimal representado en compemento a 2): "
  texto_resultado_inf: .asciiz "Parte inferior(decimal representado en compemento a 2): "
  texto_newline: .asciiz "\n"
