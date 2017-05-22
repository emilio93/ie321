
# Emilio Rojas 2017

# calculo de la hipotenusa segun el teorema de
# pitagoras
# hip = sqrt(c1^2 + c2^2)
#
# recibe los catetos 1 y 2
# $f0 cateto 1
# $f1 cateto 2

hipotenusa:
  hipotenusa_guardar_registros:
    addiu $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

  hipotenusa_calculo:
    mul.s $f2, $f0, $f0 # c1^2
    mul.s $f3, $f1, $f1 # c2^2

    add.s $f4, $f2, $f3 # c1^2 + c2^2

    mov.s $f9, $f0
    mov.s $f0, $f4

    jal raiz

  hipotenusa_fin:
    lw $ra, 0($sp)
    lw $s1, 4($sp)
    lw $s1, 8($sp)
    addiu $sp, $sp, 12
    jr $ra
