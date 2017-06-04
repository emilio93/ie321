
# Emilio Rojas 2017
#
# lectura de diferentes tipos de datos.


# solicita un entero
# devuelve el entero ingresado en $v0
solicitud_int:
  li $v0, 5 # Lee un int que queda en $v0
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

# convierte cadena de bytes(ascii) en $a0 float en $f0
#
# Este metodo resuelve si el i-esimo byte se trata de un numero, una
# coma(o punto), u otro caracter, y actua de la siguiente manera
#
# argumentos:
#   $a0: direccion de inicio de cadena de bytes con numero float
#
# devuelve:
#   $f0: el numero float representado en la cadena de bytes
#   $v0: la cantidad de bytes que se ultilizaron en la conversion
#
# Pseudocodigo
#  r = 0,0 # resultado
#  pd = 0 # contador de puntos decimales
#  leer byte b[i]
#     si b[i] es numero:
#       r = r * 10 + b[i]
#       si pd > 0
#         pd = pd + 1
#     leer byte b[i+1]
#
#     si b[i] es coma o punto:
#       si pd > 0
#         procesar y terminar ejecucion
#       pd = pd + 1 # contador se inicia en 1, se debe restar al final
#       leer byte b[i+1]
#
#     si b[i] es otro caracter:
#       procesar y terminar ejecucion
#
#     Se procesan los datos en r, pd
#       si pd > 0
#         pd = pd - 1 # se resta offset inicial del contador de puntos decimales
#       mult = potencia(10, -pd) # 10^-pd
#       r = r * mult
#
bytes_a_float:

  addi $sp, $sp, -24
  sw $ra, 0($sp)
  sw $s0, 4($sp)
  sw $s1, 8($sp)
  sw $s2, 12($sp)
  sw $s3, 16($sp)
  sw $a0, 20($sp)

  move $s0, $a0

  li.s $f0, 0,0 # salida se inicia en 0,0
  addiu $s1, $zero, 0 # contador puntos decimales

  addiu $s3, $zero, 0 # contador de iteraciones

  li.s $f2, 10,0 # multiplicador 10

  bytes_a_float_leer:
    lb $s2, 0($s0) # i-esimo byte
    addi $s0, $s0, 1 # siguiente direccion
    addi $s3, $s3, 1 # i = i+1

    move $a0, $s2

    # Punto Decimal
    li $t4, 46 # punto
    beq $s2, $t4, bytes_a_float_punto
    li $t4, 44 # coma
    beq $s2, $t4, bytes_a_float_punto

    # Numero
    jal is_byte_int # devuelve $v0 = 1 si es int, $v0 = 0 si no es int
                    #          $v1 = n si es int, $v1 = 0 si no es int
    bne $v0, $zero, bytes_a_float_numero

    # Otros
    j bytes_a_float_procesar

  bytes_a_float_numero:
    mul.s $f0, $f0, $f2 # $f0 = $f0 * 10,0
    mtc1 $v1, $f1 # $v1 es devuelto por is_byte_int
    cvt.s.w $f1, $f1
    add.s $f0, $f0, $f1
    beq $s1, $zero, bytes_a_float_leer
      addiu $s1, $s1, 1
    j bytes_a_float_leer

  bytes_a_float_punto:
    bgt $s1, $zero, bytes_a_float_procesar
    addi $s1, $s1, 1
    j bytes_a_float_leer

  bytes_a_float_procesar:
    beq $s1, $zero, taag
      addi $s1, $s1, -1
    taag:
    mov.s $f4, $f0
    sub $a0, $zero, $s1 # $a0 = - $s1
    li.s $f0, 10,0
    jal potencia
    mul.s $f0, $f0, $f4

  bytes_a_float_loop_fin:
    addi $v0, $s3, -1
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    lw $a0, 20($sp)
    addi $sp, $sp, 24
    jr $ra
