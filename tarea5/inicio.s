# Universidad de Costa Rica
# Escuela de Ingeniería Eléctrica
# Estructuras de Computadoras Digitales I - IE0321
# Tarea 5
# Emilio Javier Rojas Álvarez - B15680
#
# Programa que calcula la hipotenusa dados dos catetos
# segun la formula hip = sqrt(c1^2 + c2^2)

# data
#
#datos utilizados en el programa
.data
  texto_newline: .asciiz "\n"

  float_cte_2: .float 2.0

  ej1_cateto1: .float 3.0
  ej1_cateto2: .float 4.0
  ej1_texto: .asciiz "Cateto 1: 3.0\nCateto 2: 4.0"

  ej2_cateto1: .float 30.5
  ej2_cateto2: .float 42.7
  ej2_texto: .asciiz "Cateto 1: 30.5\nCateto 2: 42.7"

  solicitud_cateto1: .asciiz "\nIngrese el cateto 1:\n"
  solicitud_cateto2: .asciiz "\nIngrese el cateto 2:\n"

  texto_repuesta: .asciiz "La hipotenusa es:"

.text

# main
#
# metodo main se ejecuta al inicio del programa
main:
  # label del inicio del programa
  inicio:
    ejemplo1:
      # cargar catetos ejemplo 1
      lwc1 $f0, ej1_cateto1
      lwc1 $f1, ej1_cateto2

      # calcular hipotenusa en $f1
      jal hipotenusa

      # impresiones para ejemplo 1
      la $a0, ej1_texto
      jal imprimir_asciiz

      jal newline

      la $a0, texto_repuesta
      jal imprimir_asciiz

      jal newline

      # $f1 a $f12 para impresion
      mov.s $f12, $f1
      jal imprimir_float

      jal newline

    ejemplo2:
      # cargar catetos ejemplo 2
      lwc1 $f0, ej2_cateto1
      lwc1 $f1, ej2_cateto2

      # calcular hipotenusa en $f1
      jal hipotenusa

      # impresiones para ejemplo 2
      la $a0, ej2_texto
      jal imprimir_asciiz

      jal newline

      la $a0, texto_repuesta
      jal imprimir_asciiz

      jal newline

      # $f1 a $f12 para impresion
      mov.s $f12, $f1
      jal imprimir_float

      jal newline

    # permite al usuario definir dos catetos para obtener la hipotenusa
    # correspondiente
    programa_usuario:
      solicitar_c1:
        la $a0, solicitud_cateto1
        jal imprimir_asciiz

        jal solicitud_float
        mov.s $f1, $f0 # cateto 1 en $f1, orden no importa

      solicitar_c2:
        la $a0, solicitud_cateto2
        jal imprimir_asciiz

        jal solicitud_float # cateto 2 en $f0
        
      calculo:
        jal hipotenusa

      respuesta:
        la $a0, texto_repuesta
        jal imprimir_asciiz

        # $f1 a $f12 para impresion
        mov.s $f12, $f1
        jal imprimir_float

      # vuelve a solicitar datos a usuario para calculo de la hipotenusa
      reiniciar:
        j programa_usuario

    # nunca se llega acá, pero parece adecuado tener esta etiqueta
    # sirve para probar cosas sin pasar por programa_usuario
    fin:
      addi $v0, $zero, 10
      syscall
