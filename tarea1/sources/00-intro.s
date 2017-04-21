# Universidad de Costa Rica
# Escuela de Ingeniería Eléctrica
# Estructuras de Computadoras Digitales I - IE0321
# Tarea 1
# Emilio Javier Rojas Álvarez - B15680
#
# Se implementa el siguiente pseudocodigo en MIPS
# inicio:
#   solicitar entero n
#   si n < 0 || n > 45 ir a inicio
#   j = 0
#   i = 1
#   k = 0
#   while k <= n
#     l = i + j
#     j = i
#     i = l
#     if k != 0 imprimir coma
#     imprimir numero
#     k = k + 1
#   devolver j

.text
