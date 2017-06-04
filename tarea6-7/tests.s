
tests_programa_rpn:
  tests_programa_rpn_guardar_registros:
    addiu $sp, $sp, -16
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    s.s $f0, 8($sp)
    s.s $f12, 12($sp)
    # j tests_programa_rpn_potencia
    # j test_raiz
    # j tests_rpn_stack

  tests_programa_rpn_potencia:
    li $a0, 0x506f7465
    jal imprimir_bytes_registro # Pote
    li $a0, 0x6e636961
    jal imprimir_bytes_registro # ncia
    jal newline

    li.s $f0, 0,25
    li $a0, -2
    jal potencia
    mov.s $f12, $f0
    jal imprimir_float # debe imprimir 16,0
    jal newline

    li.s $f0, 0,25
    li $a0, 0
    jal potencia
    mov.s $f12, $f0
    jal imprimir_float # debe imprimir 1,0
    jal newline

    li.s $f0, 0,5
    li $a0, -1
    jal potencia
    mov.s $f12, $f0
    jal imprimir_float # debe imprimir 2,0
    jal newline

    li.s $f0, 25,0
    li $a0, 1
    jal potencia
    mov.s $f12, $f0
    jal imprimir_float # debe imprimir 25,0
    jal newline

    li.s $f0, 4,0
    li $a0, 2
    jal potencia
    mov.s $f12, $f0
    jal imprimir_float # debe imprimir 16,0
    jal newline

    li.s $f0, 2,0
    li $a0, 15
    jal potencia
    mov.s $f12, $f0
    jal imprimir_float # debe imprimir 32768,000
    jal newline

    li.s $f0, 2,0
    li $a0, 100
    jal potencia
    mov.s $f12, $f0
    jal imprimir_float # muy grande
    jal newline

    jal potencia_iterativo
    mov.s $f12, $f0
    jal imprimir_float # muy grande, mas lento
    jal newline

  test_raiz:
    jal newline
    li $a0, 0x5261697a
    jal imprimir_bytes_registro # Raiz
    jal newline

    li.s $f0, 4,0
    jal raiz
    mov.s $f12, $f1
    jal imprimir_float # debe imprimir 2
    jal newline

    li.s $f0, 0,0
    jal raiz
    mov.s $f12, $f1
    jal imprimir_float # debe imprimir 0
    jal newline

    li.s $f0, -4,0
    jal raiz
    mov.s $f12, $f1
    jal imprimir_float # debe imprimir error y terminar el programa
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
