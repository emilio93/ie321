# Universidad de Costa Rica
# Escuela de Ingeniería Eléctrica
# Estructuras de Computadoras Digitales I - IE0321
# Tarea 3
# Emilio Javier Rojas Álvarez - B15680
#
# Se implementa el algoritmo tal cual de
# la figura 3.5 del libro de texto.
# Se utiliza aritmética de 64 bits para poder
# representar una multiplicación de dos numeros
# cuya suma de bits significativos sea mayor a
# 32
# Adicional a esto una interfaz simple para
# que el usuario realice las multiplicaciones

# data
#
#datos utilizados en el programa
.data
  solicitud_multiplicando: .asciiz "Ingrese el multiplicando:\n"
  solicitud_multiplicador: .asciiz "Ingrese el multiplicador:\n"
  texto_resultado: .asciiz "Resultado: "
  texto_resultado_sup: .asciiz "Parte superior(decimal representado en compemento a 2): "
  texto_resultado_inf: .asciiz "Parte inferior(decimal representado en compemento a 2): "
  texto_newline: .asciiz "\n"


.text

# main
#
# metodo main se ejecuta al inicio del programa
main:
  # etiqueta de inicio del programa
  # sirve para poder regresar al inicio del programa
  inicio:

    # Solicita el multiplicando al usuario
    solicitar_multiplicando:
      # imprimir la solictud
      li $v0, 4 # print string
      la $a0, solicitud_multiplicando
      syscall

      # leer entrada del usuario
      li $v0, 5 # read int
      syscall

      # guardar la entrada del usuaro en registro
      add $t0, $zero, $v0

    # Solicita el multiplicador al usuario
    solicitar_multiplicador:
      # imprimir solicitud
      li $v0, 4 # print string
      la $a0, solicitud_multiplicador
      syscall

      # leer entrada del usuario
      li $v0, 5 # read int
      syscall

      # guardar entrada del usuario en registro
      add $t1, $zero, $v0 # guardar respuesta en $t1

    # asigna el multiplicando y multiplicador a los
    # argumentos $a0 y $a1
    asignar_variables:
      move $a0, $t0
      move $a1, $t1

    # ejecuta la multiplicacion
    llamar_multiplicar:
      jal multiplicar

    # indica la respuesta de la multiplicacion
    imprimir_respuesta:
      move $s0, $v0 # mantener en $s0 parte superior
      move $s1, $v1 # mantener en $s1 parte inferior

      li $v0, 4 # print string
      la $a0, texto_resultado
      syscall

      jal newline

      li $v0, 4 # print string
      la $a0, texto_resultado_sup
      syscall

      li $v0, 1 # print int
      move $a0, $s0
      syscall

      jal newline

      li $v0, 4 # print string
      la $a0, texto_resultado_inf
      syscall

      li $v0, 1 # print int
      move $a0, $s1
      syscall

    # permite realizar otra multiplicacion
    reiniciar:
      jal newline
      j inicio

    addi $v0, $zero, 10
    syscall

# imprime un caracter newline (\n)
newline:
  move $t1, $a0
  move $t2, $v0
  li $v0, 4
  la $a0, texto_newline
  syscall
  move $a0, $t1
  move $v0, $t2
  jr $ra
