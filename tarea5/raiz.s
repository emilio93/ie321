
# Emilio Rojas 2017

# calcula la raiz de un numero en punto flotante de presicion simple
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
raiz:
  raiz_guardar_registros:
    addiu $sp, $sp, -8
    sw $s0, 0($sp)
    sw $s1, 4($sp)

  raiz_iniciar:
    addiu $s0, $zero, 0 # contador i
    addiu $s1, $zero, 20 # limite

    # 2 en punto flotante
    li.s $f1, 2.0

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

  raiz_fin:
    mov.s $f1, $f2 # se devuelve resultado en $f1

    lw $s0, 0($sp)
    lw $s1, 4($sp)
    addiu $sp, $sp, 8
    jr $ra
