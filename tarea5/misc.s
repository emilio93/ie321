
# Emilio Rojas 2017

# misc.s define funciones de uso comun
# en multiples programas de mips

# imprime un caracter newline
# no modifica registros(mantiene sus
# valores una vez que se sale de la
# funcion)
newline:
  move $t0, $v0 # guardar $v0
  move $t1, $a0 # guardar $a0
  addi $v0, $zero, 4
  la $a0, texto_newline
  syscall
  move $v0, $t0 # recuperar $v0
  move $a0, $t1 # recuperar $a0
  jr $ra

# solicita un entero
solicitud_int:
  li $v0, 1 # Lee un int que queda en $v0
  syscall
  jr $ra

# solicita un float
solicitud_float:
  move $t0, $v0 # guardar $v0
  li $v0, 6 # Lee un float que queda en $f0
  syscall
  move $v0, $t0 # recuperar $v0
  jr $ra

# imprime el float en $f12
imprimir_float:
  move $t0, $v0 # guardar $v0
  addiu $v0, $zero, 2
  syscall
  move $v0, $t0 # recuperar $v0
  jr $ra


# imprime la direccion en $a0
imprimir_asciiz:
  move $t0, $v0 # guardar $v0
  addiu $v0, $zero, 4
  syscall
  move $v0, $t0 # recuperar $v0
  jr $ra

# chequear $f0 > 0
respuesta_mayor_a_cero:
  addiu $v0, $zero, 0 # respuesta se inicializa en 0

  mfc1 $t0, $f1 # guardar $f1
  li.s $f1, 0,0
  c.le.s $f0, $f1
  mtc1 $t0, $f1 # recuperar $f1
  bc1f respuesta_menor_a_cero
  addiu $v0, $zero, 1
  respuesta_menor_a_cero:
  jr $ra

# chequear no overflow
no_infinito:
  li $t0, 0x7f800000
  mfc1 $t1, $f0
  seq $v0, $t0, $t1
  jr $ra
