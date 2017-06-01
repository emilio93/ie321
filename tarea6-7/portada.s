# Universidad de Costa Rica
# Escuela de Ingeniería Eléctrica
# Estructuras de Computadoras Digitales I - IE0321
# Tarea 6-7
# Emilio Javier Rojas Álvarez - B15680
#

# Calculadora RPN (reverse polish notation - notacion polaca inversa)
#
# Uso:
#   # suma
#     > 3 4 +
#     7 (3 + 4)
#
#   # resta
#     > 7 4 -
#     3 (7 - 4)
#
#   # multiplicacion
#     > 3 4 *
#     12 (3 * 4)
#
#   # division
#     > 6 3 /
#     2 (6 / 3)
#
#   # raiz cuadrada
#     > 36 s
#     6 (sqrt(6))
#
#     > 36 S
#     6 (sqrt(6))
#
#   # potencia
#     > 5 3 p
#     125 (5^3)
#
#     > 0,5 -2 P
#     4 ((1\2)^(-2) = (1/(1/2))^(2) = 2^2)
#
#   # eliminar datos
#     > 5 5 + c
#     (se elimina el stack)
#     > 3 2 - C
#     (se elimina el stack)
