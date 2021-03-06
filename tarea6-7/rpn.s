
# Ejecuta la operacion en la direccion $a0 con $a1 caracteres
#
# $a0 es la direccion donde empieza instruccion RPN
# $a1 es la cantidad de caracteres en la instruccion
rpn:
  # guardar registros en el stack pointer
  # inicializar variables necesarias
  rpn_iniciar:
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)

    addiu $s0, $zero, 0 # contador, limite es $a1 o caso null

    j rpn_leer

  # Lee el siguente byte de la cadena y actua de acuerdo al
  # byte recibido de acuerdo al estandar ascii
  rpn_leer:
    addu $t0, $s0, $a0 # obtener direccion del elemento actual del argumento $a0
    move $s2, $t0 # s2 es la direccion del elemento actual durante toda la iteracion
    lb $t0, 0($t0) # obtener caracter en la direccion actual

    # branch a casos

    # null:0 finalizar ejecucion
    beq $t0, $zero, rpn_null
    # \n:10 caracter newline finalizar ejecucion
    addiu $t1, $zero, 10
    beq $t0, $t1, rpn_null

    # space:32 imprimir ultimo en pila de la calculadora
    addiu $t1, $zero, 32
    beq $t0, $t1, rpn_space

    # *:42 multiplicar
    addiu $t1, $zero, 42
    beq $t0, $t1, rpn_multiplicar

    # +:43 sumar
    addiu $t1, $zero, 43
    beq $t0, $t1, rpn_sumar

    # -:45 restar
    addiu $t1, $zero, 45
    beq $t0, $t1, rpn_restar

    # /:47 dividir
    addiu $t1, $zero, 47
    beq $t0, $t1, rpn_dividir

    # C:67 reiniciar stack
    addiu $t1, $zero, 67
    beq $t0, $t1, rpn_reiniciar

    # P:80 potencia
    addiu $t1, $zero, 80
    beq $t0, $t1, rpn_potencia

    # S:83 raiz cuadrada
    addiu $t1, $zero, 83
    beq $t0, $t1, rpn_raiz

    # c:99 reiniciar stack
    addiu $t1, $zero, 99
    beq $t0, $t1, rpn_reiniciar

    # p:112 potencia
    addiu $t1, $zero, 112
    beq $t0, $t1, rpn_potencia

    # s:115 raiz cuadrada
    addiu $t1, $zero, 115
    beq $t0, $t1, rpn_raiz

    # 0:48 - 9:57 numeros
    addi $sp, $sp, -4
    sw $a0, 0($sp)# guardar $a0
    move $a0, $t0
    jal is_byte_int # indica si el byte $a0 representa un numero en ascii
    lw $a0, 0($sp)# recuperar $a0
    addi $sp, $sp, 4
    # su $v0 es 1(no 0), se tiene que es un numero
    bne $v0, $zero, rpn_num

    # cualquier otro caso es un caracter invalido
    j rpn_caracter_invalido

    rpn_leer_check:
      addiu $s0, $s0, 1
      j rpn_leer

  # caracter null(o newline) indica el fin de la instruccion
  # termina la ejecucion de la calculadora rpn y espera siguente
  # instruccion
  rpn_null:
    j rpn_fin

  # caracter espacio[ ]
  # imprime ultimo elemento
  # apilado en la pila
  rpn_space:
    jal rpn_ver
    mov.s $f12, $f0 # argumento es $f12
    jal imprimir_float
    jal newline
    j rpn_leer_check

  # caracter *
  # desapila y multiplica los dos ultimos
  # elementos(float) de la pila
  rpn_multiplicar:
    jal rpn_desapilar
    bne $v1, $zero, rpn_fin
    mov.s $f1, $f0 # guardar resultado en $f1

    jal rpn_desapilar
    bne $v1, $zero, rpn_fin

    mul.s $f0, $f0, $f1 # multiplicar ultimo desapilado($f0) por $f1

    jal rpn_apilar
    bne $v1, $zero, rpn_fin

    j rpn_leer_check

  # caracter +
  # desapila y suma los dos ultimos
  # elementos de la pila
  rpn_sumar:
    jal rpn_desapilar
    bne $v1, $zero, rpn_fin
    mov.s $f1, $f0 # guardar resultado en $f1

    jal rpn_desapilar
    bne $v1, $zero, rpn_fin

    add.s $f0, $f0, $f1 # sumar ultimo desapilado($f0) con $f1

    jal rpn_apilar
    bne $v1, $zero, rpn_fin

    j rpn_leer_check

  # caracter -
  # desapila y resta los dos ultimos
  # elementos del stack(ultimo - penultimo)
  rpn_restar:
    jal rpn_desapilar
    bne $v1, $zero, rpn_fin
    mov.s $f1, $f0 # guardar resultado en $f1

    jal rpn_desapilar
    bne $v1, $zero, rpn_fin

    sub.s $f0, $f0, $f1 # restarle al ultimo desapilado($f0), $f1

    jal rpn_apilar
    bne $v1, $zero, rpn_fin

    j rpn_leer_check

  # caracter /
  # desapila y divide ultimos 2 numeros en la pila
  rpn_dividir:
    jal rpn_desapilar
    bne $v1, $zero, rpn_fin
    mov.s $f1, $f0

    # error en division por cero
    li.s $f2, 0,0
    c.eq.s $f1, $f2
    bc1t rpn_error_division_cero

    jal rpn_desapilar
    bne $v1, $zero, rpn_fin

    div.s $f0, $f0, $f1

    jal rpn_apilar
    bne $v1, $zero, rpn_fin

    j rpn_leer_check

  # Convierte una entrada de bytes representando un numero a un float
  # el primer elemento debe ser un numero
  rpn_num:
    addi $sp, $sp, -4
    sw $a0, 0($sp)

    move $a0, $s2
    jal bytes_a_float
    add $s2, $s2, $v0
    add $s0, $s0, $v0
    addi $s0, $s0, -1

    jal rpn_apilar
    bne $v1, $zero, rpn_fin

    lw $a0, 0($sp)
    addi $sp, $sp, 4

    j rpn_leer_check

  # reinicializa la pila
  rpn_reiniciar:
    jal rpn_stack_iniciar
    li.s $f0, 0,0
    jal rpn_apilar
    j rpn_leer_check

  # calcula la potencia del penultimo numero
  # elevado al ultimo numero
  rpn_potencia:
    addi $sp, $sp, -8 # $a0 se debe guardar
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    jal rpn_desapilar
    bne $v1, $zero, rpn_fin

    cvt.w.s $f1, $f0
    mfc1 $a0, $f1 # la potencia es un argumento tipo int

    jal rpn_desapilar
    bne $v1, $zero, rpn_fin

    jal potencia # calculo de potencia

    jal rpn_apilar
    bne $v1, $zero, rpn_fin

    sw $ra, 0($sp)
    lw $a0, 4($sp) # se recupera $a0
    addi $sp, $sp, 8

    j rpn_leer_check

  # calcula la raiz
  rpn_raiz:
    # obtener argumento
    jal rpn_desapilar
    bne $v1, $zero, rpn_fin

    # identificar error(argumento menor a cero)
    li.s $f1, 0,0
    c.lt.s $f0, $f1
    bc1t rpn_raiz_error_menor_a_cero

    # calcular raiz
    jal raiz
    mov.s $f0, $f1

    # guardar resultado
    jal rpn_apilar
    bne $v1, $zero, rpn_fin

    j rpn_leer_check

  # indica que hay un caracter invalido en la instruccion,
  # indica la posicion y continua con el resto de la
  # instruccion ignorando el caracter invalido.
  rpn_caracter_invalido:
    # $a0 no se guarda porque no se va a necesitar mas en esta ejecucion de rpn
    la $a0, texto_error_caracter_invalido_1
    jal imprimir_asciiz

    # imprimir caracter invalido
    move $a0, $s2 # argumento $a0 es direccion del primer byte
    addiu $a1, $zero, 1 # argumento $a1 indica cantidad de bytes
                        # solo se imprime un caracter
    jal imprimir_bytes

    # impresion texto 2 del error
    la $a0, texto_error_caracter_invalido_2
    jal imprimir_asciiz

    # obtener posicion del caracter invalido dentro de la instruccion
    # para obtener posición de caracter invalido
    la $t0, input_string
    sub $a0, $s2, $t0
    jal imprimir_int

    # indicar fin de ejecucion de la instruccion
    la $a0, texto_fin_instruccion
    jal imprimir_asciiz

    jal newline
    j rpn_fin

  # indica argumento invalido para la raiz cuadrada
  rpn_raiz_error_menor_a_cero:
    # se reintegra valor para no alterar la pila
    jal rpn_apilar

    # se imprime mensaje de error
    # $a0 no se guarda porque no se va a necesitar mas en esta ejecucion de rpn
    la $a0, texto_error_raiz_menor_a_cero
    jal imprimir_asciiz

    # indicar fin de ejecucion de la instruccion
    la $a0, texto_fin_instruccion
    jal imprimir_asciiz

    jal newline
    j rpn_fin

  # indica que no se puede dividir por cero
  rpn_error_division_cero:
    # se reintegra valor para no alterar la pila
    jal rpn_apilar
    # se imprime mensaje de error
    # $a0 no se guarda porque no se va a necesitar mas en esta ejecucion de rpn
    la $a0, texto_rpn_div_cero
    jal imprimir_asciiz
    la $a0, texto_fin_instruccion
    jal imprimir_asciiz
    j rpn_fin

  # finaliza ejecucion de la instruccion dada
  rpn_fin:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    addiu $sp, $sp, 16
    jr $ra
