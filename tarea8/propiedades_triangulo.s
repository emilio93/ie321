# calcula las propiedades del triangulo de lados en triangulo
#
# en $s0 devuelve perimetro
# en $s1 devuelve puntero a texto del tipo del triangulo
# en $f0 devuelve area
# en $f1 devuelve altura del lado 1
# en $f2 devuelve altura del lado 2
# en $f3 devuelve altura del lado 3
propiedades_triangulo:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  # cargar lados del triangulos
  la $t0, triangulo
  lw $t1, 0($t0)
  lw $t2, 4($t0)
  lw $t3, 8($t0)

  # perimetro es la suma de los lados
  propiedades_triangulo_perimetro:
    addu $s0, $t1, $t2
    addu $s0, $s0, $t3

  # devuelve un puntero al texto del tipo de triangulo correspondiente
  propiedades_triangulo_tipo:
    addi $s1, $zero, 0 # no se asume direccion

    # con 2 lados iguales puede ser isosceles o equlatero
    beq $t1, $t2, propiedades_triangulo_tipo_lados_iguales
    # con 2 lados iguales y otro distinto es isosceles
    beq $t2, $t3, propiedades_triangulo_tipo_isosceles
    # con los 3 lados distintos es escaleno
    j propiedades_triangulo_tipo_escaleno
    propiedades_triangulo_tipo_lados_iguales:
      # si ambos lados son distintos, es isosceles
      bne $t2, $t3, propiedades_triangulo_tipo_isosceles
      # sino, equilatero
      j propiedades_triangulo_tipo_equilatero

    # asignacion del puntero
    propiedades_triangulo_tipo_equilatero:
      la $s1, texto_tipo_equilatero
      j propiedades_triangulo_altura
    propiedades_triangulo_tipo_isosceles:
      la $s1, texto_tipo_isosceles
      j propiedades_triangulo_altura
    propiedades_triangulo_tipo_escaleno:
      la $s1, texto_tipo_escaleno
      j propiedades_triangulo_altura

  # se utiliza formula de heron para calcular la altura
  # de los lados.
  propiedades_triangulo_altura:
    # lados en floats
    mtc1 $t1, $f2
    cvt.s.w $f2, $f2

    mtc1 $t2, $f3
    cvt.s.w $f3, $f3

    mtc1 $t3, $f4
    cvt.s.w $f4, $f4

    # $f0 es semiperimetro (s)
    mtc1 $s0, $f0
    cvt.s.w $f0, $f0
    li.s $f8, 2,0
    div.s $f0, $f0, $f8


    # $f0 = 2*sqrt($f0*($f0-$f2)($f0-$f3)($f0-$f4))
    # $f0 = 2 sqrt(s(s-a)(s-b)(s-c))
    sub.s $f9, $f0, $f2
    sub.s $f10, $f0, $f3
    sub.s $f11, $f0, $f4

    mul.s $f12, $f0, $f9 # $f0 ($f0 - $f2)
    mul.s $f12, $f12, $f10 # $f0 ($f0 - $f2) ($f0 - $f3)
    mul.s $f12, $f12, $f11  # $f0 ($f0 - $f2) ($f0 - $f3) ($f0 - $f4)

    mov.s $f13, $f0
    mov.s $f0, $f12
    jal raiz # sqrt($f0 ($f0 - $f2) ($f0 - $f3) ($f0 - $f4))
    mul.s $f0, $f1, $f8 # 2 * sqrt($f0 ($f0 - $f2) ($f0 - $f3) ($f0 - $f4))

    # altura en lado 1, $t1
    # se devuelve en $f1
    div.s $f1, $f0, $f2

    # altura en lado 2, $t2
    # se devuelve en $f2
    div.s $f2, $f0, $f3

    # altura en lado 3, $t3
    # se devuelve en $f3
    div.s $f3, $f0, $f4

  # a = (h * b) / 2
  # area de devuelve en $f0
  propiedades_triangulo_area:
    mul.s $f0, $f3, $f4
    div.s $f0, $f0, $f8

  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra
