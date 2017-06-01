
# data
#
# datos utilizados en el programa
.data

  texto_newline: .asciiz "\n"
  texto_solicitud_instruccion: .asciiz "Ingrese la instruccion:\n"
  texto_error_caracter_invalido_1: .asciiz "Error, caracter no permitido: `"
  texto_error_caracter_invalido_2: .asciiz "` en la posición: "
  texto_fin_instruccion: .asciiz "\n  Se termina ejecución de la instrucción\n"
  texto_rpn_stack_error: .asciiz "\nError, stack fuera del rango permitido
  Se termina ejecución de la instrucción\n"
  texto_rpn_div_cero: .asciiz "\nError, division entre cero no permitida"
  texto_error_raiz_menor_a_cero: .asciiz "\nError, argumento de la raiz cuadrada no puede ser negativo"


  input_max_len: .word 40 # maxima cantidad de caracteres leidos
                          # deberia ser no mayo a la cantidad de espacio
                          # en input_string
  input_string: .space 40 # maxima cantidad de caracteres en input_string
  .align 2
  max_rpn_len: .word 128
  rpn_stack: .space 128 # stack para la calculadora
                        # 128 bytes = 128/4 palabras = 32 palabras = 32 floats

  texto_bienvenida: .asciiz"  _____       _            _           _
 / ____|     / |          / |         / |
 | |     __ _| | ___ _   _| | __ _  __| | ___  _ __ __ _
 | |    / _` | |/ __| | | | |/ _` |/ _` |/ _ \| '__/ _` |
 | |___| (_| | | (__| |_| | | (_| | (_| | (_) | | | (_| |
  \_____\__,_|_|\___|\__,_|_|\__,_|\__,_|\___/|_|  \__,_|
 /  __ \ /  __ \ / \ / |
 | |__) || |__) ||  \| |
 |  _  / |  ___/ | . ' |
 | | \ \ | |     | |\  | |Reverse Pilish Notation|
 |_|  \_\|_|     |_| \_| |Notación Polaca Inversa|

    Emilio Rojas 2017\n
    "
    texto_uso: .asciiz "
    Uso:
    # El espacio indica que se imprime el último elemento en la pila.
    # Se recuerda al usuario que para ver la respuesta total se
    # debe agregar un espacio al final de la instruccion(eg: \"3 4 + \")

    # suma: +                  # resta: -
      > 3 4 +                    > 7 4 -
      7 (3 + 4)                  3 (7 - 4)
                                 # numeros negativos
                                 > 0 4 -
                                 -4 (0 - 4)

    # multiplicación: *        # división: /
      > 3 4 *                    > 6 3 /
      12 (3 * 4)                 2 (6 / 3)

    # raíz cuadrada: s S       # potencia: p P
      > 36 s                     > 5 3 p
      6 (sqrt(6))                125 (5^3)

      > 36 S                     > 0,5 0 2 - P
      6 (sqrt(6))                4 ((1/2)^(-2))

    # eliminar datos: c C
      > 5 5 + c
      (se reinicializa la pila con ultimo elemento 0)
      > 3 2 - C
      (se reinicializa la pila con ultimo elemento 0)\n
"
