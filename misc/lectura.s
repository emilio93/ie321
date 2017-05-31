
# Emilio Rojas 2017
#
# lectura de diferentes tipos de datos.


# solicita un entero
# devuelve el entero ingresado en $v0
solicitud_int:
  li $v0, 1 # Lee un int que queda en $v0
  syscall
  jr $ra

# solicita un float
# devuelve el entero ingresado en $f0
solicitud_float:
  move $t0, $v0 # guardar $v0
  li $v0, 6 # Lee un float que queda en $f0
  syscall
  move $v0, $t0 # recuperar $v0
  jr $ra

# solicita una cadena de caracteres
# devuelve direccion de la cadena en $a0
solicitud_string:
  move $t0, $v0 # guardar $v0
  move $t1, $a1 # guardar $a1
  la $a0, input_string
  la $a1, input_max_len
  lw $a1, 0($a1)
  addiu $v0, $zero, 8
  syscall
  move $v0, $t0 # recuperar $v0
  move $a1, $t1 # recuperar $a1
  jr $ra
