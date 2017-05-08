
# Divide $a0 entre $a1
# y guarda el cociente en $v0
# y el residuo en $v1
#
# $a0 es dividendo-residuo
# $a1 es divisor
dividir:
  # guardar los registros en el stack pointer
  dividir_guardar_registros:
    addi $sp, $sp, -40
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $s0, 12($sp)
    sw $s1, 16($sp)
    sw $s2, 20($sp)
    sw $s3, 24($sp)
    sw $s4, 28($sp)
    sw $s5, 32($sp)
    sw $s6, 36($sp)

  # inicializa el contador, iteracion máxima
  # y valor del producto.
  dividir_iniciar_variables:
    li $s0, 0 # contador i se inicializa en 0
    li $s1, 32 # maximo iteraciones son 33

    # divisor 64 bits
    li $s2, 0
    move $s3, $a1

    # residuo-dividendo 64 bits
    li $s4, 0
    move $s5, $a0 # parte lo del residuo se inicializa con valor de dividendo

    # cociente
    li $s6, 0 # cociente se inicializa en 0

    j dividir_paso_1

  # El paso 1 es restarle al residuo el divisor y guardar resultado
  # en el residuo
  dividir_paso_1:
    # cargar argumentos
    move $a0, $s4
    move $a1, $s5
    move $a2, $s2
    move $a3, $s3

    # restar
    jal sub64

    # guardar en residuo
    move $s4, $v0
    move $s5, $v1
    j dividir_test_residuo

  # identifica si el residuo es menor a cero y actua segun el resultado
  dividir_test_residuo:
    bgt $s4, $zero, dividir_paso_2_a # parte hi del residuo debe ser 0, sino el
                                     # residuo es mayor a 0
    bge $s5, $zero, dividir_paso_2_a # if residuo >= 0 then dividir_paso_2_a
    j dividir_paso_2_b

  # no hace nada, pasa directo al paso 3
  dividir_paso_2_a:
    j dividir_paso_3

  # guarda en residuo la suma del residuo y el divisor
  # desplaza cociente a la izquierda un bit
  # asigna 1 el LSB del cociente
  dividir_paso_2_b:
    # cargar argumentos para la resta
    move $a0, $s4
    move $a1, $s5
    move $a2, $s2
    move $a3, $s3

    jal sum64

    # guardar resultado en residuo
    move $s4, $v0
    move $s5, $v1

    sll $s6, $s6, 1

    j dividir_paso_3

  # rotar divisor a la derecha
  dividir_paso_3:
    move $a0, $s2
    move $a1, $s3
    jal srl64
    move $v0, $s2
    move $v1, $s3

  # asegurarse que se hagan las 33 iteraciones necesarias
  # y salir cuando se cumplan
  dividir_check_iteration:
    bgt $s0, $s1, dividir_restaurar_registros
    addi $s0, $s0, 1
    j dividir_paso_1

  # restaurar los registros del stack pointer
  # y regresar al programa mediante $ra
  dividir_restaurar_registros:
    # valores devueltos
    move $s6, $v0
    move $s5, $v1

    lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    lw $s0, 12($sp)
    lw $s1, 16($sp)
    lw $s2, 20($sp)
    lw $s3, 24($sp)
    lw $s4, 28($sp)
    lw $s5, 32($sp)
    lw $s6, 36($sp)
    addi $sp, $sp, 40
    jr $ra
