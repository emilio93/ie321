# Solicita los lados al usuario y los almacena en triangulo
# devuelve la direccion triangulo en $v0
obtener_lados_triangulo:
  obtener_lados_triangulo_guardar_registros:
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $a0, 12($sp)

  obtener_lados_triangulo_inicio:
    # en la direccion $s0 se tiene el primer lado del triangulo
    # en la direccion ($s0+4) se tiene el segundo lado del triangulo
    # en la direccion ($s0+8) se tiene el tercer lado del triangulo
    la $s0, triangulo

  obtener_lados_triangulo_1:
    la $s1, obtener_lados_triangulo_1 # puntero a este caso
    la $a0, texto_solicitar_lado_triangulo_1
    jal imprimir_asciiz

    jal solicitud_int
    # indica si el numero es invalido y solicita nuevamente el lado
    ble $v0, $zero, obtener_lados_triangulo_negativo
    sw $v0, 0($s0) # almacena el lado en 0(triangulo)

  obtener_lados_triangulo_2:
    la $s1, obtener_lados_triangulo_2 # puntero a este caso
    la $a0, texto_solicitar_lado_triangulo_2
    jal imprimir_asciiz

    jal solicitud_int
    # indica si el numero es invalido y solicita nuevamente el lado
    ble $v0, $zero, obtener_lados_triangulo_negativo
    sw $v0, 4($s0) # almacena el lado en 4(triangulo)

  obtener_lados_triangulo_3:
    la $s1, obtener_lados_triangulo_3 # puntero a este caso
    la $a0, texto_solicitar_lado_triangulo_3
    jal imprimir_asciiz

    jal solicitud_int
    # indica si el numero es invalido y solicita nuevamente el lado
    ble $v0, $zero, obtener_lados_triangulo_negativo
    sw $v0, 8($s0) # almacena el lado en 8(triangulo)

    la $v0, triangulo # devuelve direccion del triangulo
    j obtener_lados_triangulo_restaurar_registros

  obtener_lados_triangulo_restaurar_registros:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $a0, 12($sp)
    addi $sp, $sp, 16
    jr $ra

  obtener_lados_triangulo_negativo:
    # se indica error en el valor ingresado
    la $a0, texto_solicitar_lado_triangulo_error_negativo
    jal imprimir_asciiz

    # en s1 esta el puntero a la instruccion en la cual el usuario digito un
    # numero no valido(no positivo, n<=0).
    jr $s1
