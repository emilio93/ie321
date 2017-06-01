tests_programa_rpn:
  tests_programa_rpn_guardar_registros:
    addiu $sp, $sp, -16
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    s.s $f0, 8($sp)
    s.s $f12, 12($sp)
    j tests_rpn_stack

  tests_programa_rpn_potencia:
    li.s $f0, 0,25
    li $a0, -2
    jal potencia
    mov.s $f12, $f0
    jal imprimir_float
    jal newline

    li.s $f0, 0,25
    li $a0, 0
    jal potencia
    mov.s $f12, $f0
    jal imprimir_float
    jal newline

    li.s $f0, 0,5
    li $a0, -1
    jal potencia
    mov.s $f12, $f0
    jal imprimir_float
    jal newline

    li.s $f0, 25,0
    li $a0, 1
    jal potencia
    mov.s $f12, $f0
    jal imprimir_float
    jal newline

    li.s $f0, 4,0
    li $a0, 2
    jal potencia
    mov.s $f12, $f0
    jal imprimir_float
    jal newline

    li.s $f0, 2,0
    li $a0, 15
    jal potencia
    mov.s $f12, $f0
    jal imprimir_float
    jal newline

    li.s $f0, 2,0
    li $a0, 100
    jal potencia
    mov.s $f12, $f0
    jal imprimir_float
    jal newline

    jal potencia_iterativo
    mov.s $f12, $f0
    jal imprimir_float
    jal newline

    li $a0, 0x31323334
    jal imprimir_bytes_registro
    jal newline

  tests_rpn_stack:

    li.s $f4, 1,0
    li.s $f5, 2,5
    li.s $f6, 3,33
    jal rpn_stack_iniciar

    mov.s $f0, $f4
    jal rpn_apilar

    mov.s $f0, $f5
    jal rpn_apilar

    mov.s $f0, $f6
    jal rpn_apilar

    # deberia imprimir 3,33
    jal rpn_desapilar
    mov.s $f12, $f0
    jal imprimir_float
    jal newline

    # deberia imprimir 2,5
    jal rpn_ver
    mov.s $f12, $f0
    jal imprimir_float
    jal newline

    # deberia imprimir 2,5
    jal rpn_desapilar
    mov.s $f12, $f0
    jal imprimir_float
    jal newline

    # deberia imprimir 1,0
    jal rpn_desapilar
    mov.s $f12, $f0
    jal imprimir_float
    jal newline

    # deberia tirar error
    jal rpn_desapilar
    mov.s $f12, $f0
    jal imprimir_float
    jal newline

  tests_programa_rpn_fin:
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    l.s $f0, 8($sp)
    l.s $f12, 12($sp)
    addiu $sp, $sp, 16
    jr $ra
