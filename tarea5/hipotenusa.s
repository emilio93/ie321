
# Emilio Rojas 2017

# calculo de la hipotenusa segun el teorema de
# pitagoras
# hip = sqrt(c1^2 + c2^2)
#
# recibe los catetos 1 y 2
# $f0 cateto 1
# $f1 cateto 2
#
# respuesta en $f0

hipotenusa:
  hipotenusa_guardar_registros:
    addiu $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

  hipotenusa_calculo:
    # mascara para chequear infinito
    # infinito representado en float:
    # s|exponente |fraccion
    # 0|111 1111 1|000 0000 0000 0000 0000 0000
    li $t0, 0x7f800000

    # elevar al cuadrado y chequear no overflow en cateto 1
    mul.s $f2, $f0, $f0 # c1^2
    mfc1 $t1, $f2 # bits de $f2 en $t1
    beq $t1, $t0, hipotenusa_error # indicar error

    # elevar al cuadrado y chequear no overflow en cateto 2
    mul.s $f3, $f1, $f1 # c2^2
    mfc1 $t1, $f3
    beq $t1, $t0, hipotenusa_error

    # sumar cuadrados y chequear overflow
    add.s $f4, $f2, $f3 # c1^2 + c2^2
    mfc1 $t1, $f4
    beq $t1, $t0, hipotenusa_error

    mov.s $f0, $f4 # resultado en $f0

    # se le calcula la raiz a $f0 = c1^2 + c2^2
    jal raiz

    j hipotenusa_fin

  hipotenusa_error:
    mtc1 $t0, $f0 # se devuelve inf para indicar error

  hipotenusa_fin:
    lw $ra, 0($sp)
    lw $s1, 4($sp)
    lw $s1, 8($sp)
    addiu $sp, $sp, 12
    jr $ra
