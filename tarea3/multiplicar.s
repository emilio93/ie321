
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
    li $s1, 31 # cantidad [maxima] de iteraciones - 1
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
