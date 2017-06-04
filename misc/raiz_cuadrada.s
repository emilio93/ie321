
# Emilio Rojas 2017

# raiz.s contiene una funcion que calcula la raiz cuadrada de
# un numero segun el metodo newtoniano.

# calcula la raiz de un numero en punto flotante de presicion simple
# Se debe asegurar que el argumento $f0 sea mayor o igual a 0,0
# de otra manera se finaliza la ejecución del programa
#
# $f0 es el numero del cual se calcula la raiz
# $f1 es la raiz del numero en $f0
#
# se utiliza metodo newtoniano para la raiz
# $f0 = N
# $f2 = x = N/2
# $f3 = x'
# $s0 = i
# $s1 = 20
# repetir 20 veces:
#   x' = (x+N/x)/2
#   x = x'
.data
  raiz_texto_error_negativo: .asciiz "\nError, argumento negativo en la raiz
  Fin del programa"
.text

raiz:
  raiz_guardar_registros:
    addiu $sp, $sp, -8
    sw $s0, 0($sp)
    sw $s1, 4($sp)

  raiz_iniciar:
    # chequear casos iniciales $f0 = 0,0 o $f0 < 0,0
    # con $f0 = 0,0 se devuelve 0 (se debe hacer porque se realiza una
    # división entre cero en el algoritmo utilizado:
    # $f2 = x = N/2
    # ...
    # x' = (x+N/x)/2
    # )
    li.s $f1, 0,0 # se asume valor 0, se utiliza para comparar tambien
    c.eq.s $f0, $f1 # bc1t = $f0 == 0,0
    bc1t raiz_fin # se devuelve $f1 = 0,0

    c.lt.s $f0, $f1 # bc1t = $f0 < 0,0
    bc1t raiz_error_negativo # se finaliza ejecucion del programa,
                             # corrección para esto se hace fuera
                             # de la funcion

    addiu $s0, $zero, 0 # contador i
    addiu $s1, $zero, 20 # limite

    # 2 en punto flotante
    addiu $t0, $zero, 2
    mtc1 $t0, $f1
    cvt.s.w $f1, $f1

    # x = N/2
    # $f2 = $f0/2.0
    div.s $f2, $f0, $f1

  raiz_loop:
    # x' = (x + N/x)/2
    div.s $f3, $f0, $f2
    add.s $f3, $f3, $f2
    div.s $f3, $f3, $f1

    # x = x'
    mov.s $f2, $f3

    # i++, i<20?
    addiu $s0, $s0, 1
  blt $s0, $s1, raiz_loop

  mov.s $f1, $f2 # se devuelve resultado en $f1

  raiz_fin:
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    addiu $sp, $sp, 8
    jr $ra

  raiz_error_negativo:
    la $a0, raiz_texto_error_negativo
    jal imprimir_asciiz
    addiu $v0, $zero, 10
    syscall
