
# Emilio Rojas 2017

# chequear que el contenido de $f0 sea mayor a 0
#
# $v0 es 0 si la respuesta es menor o igual a 0
# $v0 es 1 si la respuesta es mayor a 0
respuesta_mayor_a_cero:
  # se asume que $f0 <= 0
  addiu $v0, $zero, 0 # respuesta se inicializa en 0

  mfc1 $t0, $f1 # guardar $f1

  # comparar con 0
  li.s $f1, 0,0
  c.le.s $f0, $f1

  bc1f respuesta_menor_a_cero # si $f0 > $f1
    addiu $v0, $zero, 1 # se asigna la respuesta a 1
  respuesta_menor_a_cero: # si $f0 <= $f1
    # no sucede nada, ya se asumio que $v0 es 0
  mtc1 $t0, $f1 # recuperar $f1
  jr $ra

# chequear que no haya un overflow en $f0
#
# $v0 es 1 si $f0 es infinito(IEEE754) punto flotante
no_infinito:
  li $t0, 0x7f800000 # mascara para infinito
  mfc1 $t1, $f0 # pasar bits de $f0 a $t0
  addiu $v0, $zero, 0 # $v0=0 (se asume)
  seq $v0, $t0, $t1 # set $v0=1 if $t0==$t1
  jr $ra

# devuelve en $v0 el menor entre $a0 y $a1
min_int:
  blt $a0, $a1, min_int_a0
    move $v0, $a1
    j min_int_fin
  min_int_a0:
    move $v0, $a0
  min_int_fin:
    jr $ra

  # devuelve en $v0 el mayor entre $a0 y $a1
  max_int:
    bgt $a0, $a1, max_int_a0
      move $v0, $a1
      j max_int_fin
    max_int_a0:
      move $v0, $a0
    max_int_fin:
      jr $ra

# cuenta la cantidad de caracteres en un string
#
# string comienza en direccion $a0 y termina al
# haber un caracter NULL
#
# devuelve la cantidad de caracteres en $v0
len_string:
  addu $v0, $zero, $a0 # contador(+$a0)
  addiu $t0, $zero, 10 # caracter \n

  len_string_loop:
    # obtener caracter en $t1
    lb $t1, 0($v0) # iesimo caracter

    # caracter NULL o \n, finaliza la cuenta
    beq $t1, $zero, len_string_fin # a[i] = NULL
    beq $t1, $t0, len_string_fin # a[i] = \n

    addiu $v0, $v0, 1 # direccion del siguiente caracter
    j len_string_loop

  len_string_fin:
    subu $v0, $v0, $a0 # contador final
    jr $ra

# igual a len_string, pero en vez de NULL o /n, termina
# cuando lee $a1, que es el codigo ascii del caracter
# limitante
#
# devuelve la cantidad de caracteres en $v0
len_string_char:

  len_string_char_loop:
    # obtener caracter en $t1
    lb $t1, 0($v0) # iesimo caracter

    # caracter en $a0 finaliza cuenta
    beq $t1, $a1, len_string_fin # a[i] = char en $a0

    addiu $v0, $v0, 1 # direccion del siguiente caracter
    j len_string_loop

  len_string_char_fin:
    subu $v0, $v0, $a0 # contador final
    jr $ra

# Obtiene en $f0 la representacion float(IEEE754) de un numero
# en la direccion $a0
#
# el formato del numero debe ser el siguiente
# (n[n])(n[n-1])...(n[1])(n[0])(,)(n[-1])(n[-2])...(n[-m])
# notese que se permiten unicamente numeros y coma (0-9,)
#
# si el primer caracter de la direccion $a0 no es (0-9,),
# se devuelve 0,0
#
# se devuelve inf en caso de overflow
extract_num:
  li.s $f0, 0,0 # se incializa resultado en 0
