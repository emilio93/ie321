# Universidad de Costa Rica
# Escuela de Ingeniería Eléctrica
# Estructuras de Computadoras Digitales I - IE0321
# Tarea 2
# Emilio Javier Rojas Álvarez - B15680
#
# Se implementa el siguiente pseudocodigo en mips
# para ordenar un arreglo dado, segun el algoritmo
# bubble sort
#
# procedure bubbleSort( A : list of sortable items )
# n = length(A)
#     repeat
#         newn = 0
#         for i = 1 to n-1 inclusive do
#             if A[i-1] > A[i] then
#                 swap(A[i-1], A[i])
#                 newn = i
#             end if
#         end for
#         n = newn
#     until n = 0
# end procedure

.text
