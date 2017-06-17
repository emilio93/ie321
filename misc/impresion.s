
# Emilio Rojas 2017
#
# impresion de diferentes tipos de datos. Estas funciones de impresion no
# modifican ningun registro(excepto los temporales, $t0-$t9, si bien pueden no
# modificarse todos, no se recomienda contar con que no se modifiquen)

.data
  texto_newline: .asciiz "\n"

.align 2
.text

# imprime un caracter newline
# no modifica registros(mantiene sus
# valores una vez que se sale de la
# funcion)
# modifica $t0, $t1
# Uso:
#   > jal newline
#
newline:
  move $t0, $v0 # guardar $v0
  move $t1, $a0 # guardar $a0
  addi $v0, $zero, 4
  la $a0, texto_newline
  syscall
  move $v0, $t0 # recuperar $v0
  move $a0, $t1 # recuperar $a0
  jr $ra

# imprime el int en $a0
# modifica $t0
# Uso:
#   > addi $a0, $zero, -50
#   > jal imprimir_int
#   -50
imprimir_int:
  move $t0, $v0 # guardar $v0
  addiu $v0, $zero, 1
  syscall
  move $v0, $t0 # recuperar $v0
  jr $ra

# imprime el float en $f12
# modifica $t0
# Uso:
#   > li.s $f12, 40,0
#   > jal imprimir_float
#   40,0000
imprimir_float:
  move $t0, $v0 # guardar $v0
  addiu $v0, $zero, 2
  syscall
  move $v0, $t0 # recuperar $v0
  jr $ra

# imprime el contenido de texto en la direccion en $a0
# modifica $t0
# Uso:
#   > la $a0, etiqueta_direccion
#   > jal imprimir_asciiz
#   contenido en etiqueta_direccion
imprimir_asciiz:
  move $t0, $v0 # guardar $v0
  addiu $v0, $zero, 4
  syscall
  move $v0, $t0 # recuperar $v0
  jr $ra

# imprime $a1 cantidad de bytes desde la direccion en $a0
# modifica $t0, $t1, $t2, $t3
#
# # Uso:
#   > la $a0, etiqueta_direccion
#   > addiu $a1, $zero, 5
#   > jal imprimir_bytes
#   conte
imprimir_bytes:
  move $t0, $v0 # guardar $v0
  move $t1, $a0 # guardar $a0

  addiu $t2, $a0, 0 # contador/direccion de memoria indexada
  addu $t3, $a0, $a1 # limite
  addiu $v0, $zero, 11
  imprimir_bytes_loop:
    beq $t2, $t3, imprimir_bytes_fin
    lb $a0, 0($t2) # se obtiene i-esismo byte
    syscall
    addiu $t2, $t2, 1
    j imprimir_bytes_loop
  imprimir_bytes_fin:
  move $v0, $t0 # recuperar $v0
  move $a0, $t1 # recuperar $a0
  jr $ra

# imprime los 4 bytes en el registro $a0
#
# # Uso:
#   > li $a0, 0x484f4c65
#   > jal imprimir_bytes_registro
#   HOLA
imprimir_bytes_registro:
  move $t0, $v0 # guardar $v0
  move $t1, $a0 # guardar $a0
  addiu $v0, $zero, 11

  imprimir_bytes_registro_b0:
    # sll $a0, $t1, 0
    srl $a0, $t1, 24
    syscall
  imprimir_bytes_registro_b1:
    sll $a0, $t1, 8
    srl $a0, $a0, 24
    syscall
  imprimir_bytes_registro_b2:
    sll $a0, $t1, 16
    srl $a0, $a0, 24
    syscall
  imprimir_bytes_registro_b3:
    sll $a0, $t1, 24
    srl $a0, $a0, 24
    syscall

  imprimir_bytes_registro_fin:
    move $v0, $t0 # recuperar $v0
    move $a0, $t1 # recuperar $a0
    jr $ra
