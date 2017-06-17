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

  ej1_cateto1: .float 3,0
  ej1_cateto2: .float 4,0
  ej1_texto: .asciiz "Cateto 1: 3.0\nCateto 2: 4.0"

  ej2_cateto1: .float 30,50
  ej2_cateto2: .float 42,70
  ej2_texto: .asciiz "Cateto 1: 30.5\nCateto 2: 42.7"

  solicitud_cateto1: .asciiz "Ingrese el cateto 1(mayor a 0):\n"
  solicitud_cateto2: .asciiz "Ingrese el cateto 2(mayor a 0):\n"

  texto_repuesta: .asciiz "La hipotenusa es: "
  texto_error_infinito: .asciiz "Ocurrio un overflow"
  texto_hr: .asciiz "------------------\n"

  # datos para prueba de raiz
  raiz_test_inicio: .asciiz "inicio test raiz\n"
  raiz_test_float1: .float 1,0 # raiz debe ser 1.0
  raiz_test_float2: .float 2,0 # raiz debe ser ~ 1.4142
  raiz_test_float3: .float 4,0 # raiz debe ser 2.0
  raiz_test_float4: .float 7,0 # raiz debe ser ~ 2.6457
  raiz_test_float5: .float 20,0 # raiz debe ser ~ 4.4721
  raiz_test_float6: .float 36,0 # raiz debe ser 6.0
  raiz_test_float7: .float 102,0 # raiz debe ser 10.0995
  raiz_test_float8: .float 400,0 # raiz debe ser 20.0
  raiz_test_fin: .asciiz "fin test raiz\n"

.text

# main
#
# metodo main se ejecuta al inicio del programa
main:
  # label del inicio del programa
  inicio:

    # jal test_raiz
    # # separador
    # la $a0, texto_hr
    # jal imprimir_asciiz

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

      # $f1 a $f12 para impresion de respuesta
      mov.s $f12, $f1
      jal imprimir_float

      jal newline

      # separador
      la $a0, texto_hr
      jal imprimir_asciiz

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

      la $a0, texto_hr
      jal imprimir_asciiz

    # permite al usuario definir dos catetos para obtener la hipotenusa
    # correspondiente
    programa_usuario:
      #solicitar el cateto 1
      solicitar_c1:
        la $a0, solicitud_cateto1
        jal imprimir_asciiz

        jal solicitud_float
        mov.s $f1, $f0 # cateto 1 en $f1, orden no importa

        jal respuesta_mayor_a_cero
        bne $v0, $zero, solicitar_c1

      # solicitar el cateto 2
      solicitar_c2:
        la $a0, solicitud_cateto2
        jal imprimir_asciiz

        # cateto 2 en $f0
        jal solicitud_float

        jal respuesta_mayor_a_cero
        bne $v0, $zero, solicitar_c2

      calculo:
        jal hipotenusa

        # se chequea que no haya overflow
        jal no_infinito # $v0 es 1 hay overflow
        bne $v0, $zero, error_infinito # imprime error y reinicia

      # imprime el resultado
      respuesta:
        la $a0, texto_repuesta
        jal imprimir_asciiz

        # $f1 a $f12 para impresion
        mov.s $f12, $f1
        jal imprimir_float
        j reiniciar

      # imprime error de overflow
      error_infinito:
        la $a0, texto_error_infinito
        jal imprimir_asciiz
        j reiniciar

      # vuelve a solicitar datos a usuario para calculo de la hipotenusa
      reiniciar:
        jal newline
        la $a0, texto_hr
        jal imprimir_asciiz

        j programa_usuario

    # nunca se llega acá, pero parece adecuado tener esta etiqueta
    # sirve para probar cosas sin pasar por programa_usuario
    fin:
      addi $v0, $zero, 10
      syscall
