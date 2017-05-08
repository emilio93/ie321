# Universidad de Costa Rica
# Escuela de Ingeniería Eléctrica
# Estructuras de Computadoras Digitales I - IE0321
# Tarea 4
# Emilio Javier Rojas Álvarez - B15680
#
# Se implementa el algoritmo tal cual de
# la figura 3.10 del libro de texto.
# Adicional a esto una interfaz simple para
# que el usuario realice las divisiones
#
# dividendo/divisor = cociente + residuo/divisor

# data
#
#datos utilizados en el programa
.data
  texto_newline: .asciiz "\n"
  solicitud_dividendo: .asciiz "\nIngrese el Dividendo:\n"
  solicitud_divisor: .asciiz "Ingrese el Divisor:\n"
  texto_error_divisor: .asciiz "El divisor no puede ser cero.\n"
  texto_resultado: .asciiz "Resultado(cociente + residuo/divisor): "

.text

# main
#
# metodo main se ejecuta al inicio del programa
main:
  # label del inicio del programa
  inicio:

    # Solicita el dividendo al usuario
    solicitar_dividendo:
      addi $v0, $zero,  4 # print string
      la $a0, solicitud_dividendo
      syscall
      addi $v0, $zero, 5 # read int
      syscall
      add $t0, $zero, $v0 # guardar respuesta en $t0
      j solicitar_divisor # primer solicitud no indica error de divisor cero

    # Solicita el divisor al usuario
    divisor_incorrecto:
      addi $v0, $zero,  4 # print string
      la $a0, texto_error_divisor
      syscall
    solicitar_divisor:
      addi $v0, $zero,  4 # print string
      la $a0, solicitud_divisor
      syscall
      addi $v0, $zero, 5 # read int
      syscall
      beq $v0, $zero, divisor_incorrecto # evitar divisor cero
      add $t1, $zero, $v0 # guardar respuesta en $t1

    # asigna el dividendo y divisor a los
    # argumentos $a0 y $a1
    asignar_variables:
      add $a0, $zero, $t0 # dividendo
      add $a1, $zero, $t1 # divisor

    # ejecuta la division
    llamar_dividir:
      jal dividir

    # indica la respuesta de la division
    imprimir_respuesta:
      add $t0, $zero, $v0
      li $v0, 4 # print string
      la $a0, texto_resultado
      syscall
      add $v0, $zero, $t0

      add $t0, $zero, $v0
      li $v0, 1 # print int
      add $a0, $zero, $t0
      syscall
      add $v0, $zero, $t0

      jal newline

      add $t0, $zero, $v0
      add $t1, $zero, $v1
      li $v0, 1 # print int
      add $a0, $zero, $t1
      syscall
      add $v0, $zero, $t0
      add $v1, $zero, $t1

    # permite realizar otra division
    reiniciar:
      j inicio

    addi $v0, $zero, 10
    syscall

    # imprime un caracter newline
    #
    newline:
      add $t1, $a0, $zero # guardar
      li $v0, 4
      la $a0, texto_newline
      syscall
      add $a0, $t1, $zero # recuperar
      jr $ra
