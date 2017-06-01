# Universidad de Costa Rica
# Escuela de Ingeniería Eléctrica
# Estructuras de Computadoras Digitales I - IE0321
# Tarea 6-7
# Emilio Javier Rojas Álvarez - B15680
#

# Calculadora RPN (reverse polish notation - notacion polaca inversa)
#
# los datos de la calculadora se almacenan en una pila propia con espacio
# definido, esta pila es autocontenida, pues la direccion del ultimo elemento
# se encuentra en el primer elemento del arreglo. Se definen funciones para
# iniciar la pila, apilar, desapilar y ver ultimo elemento, chequeando la
# integridad de la pila(que no se salga del rango permitido).
#
# se ha decidido agregar la funcionalidad de cualquier potencia(en vez de
# unicamente elevar al cuadrado)
#
# se pueden ingresar multiples comandos en una sola instruccion
# eg:
#   "5 6 + "
#     que imprime(o similar)
#     5.000
#     6.000
#     11.000
#   distinto a
#   "5 6+ "
#   5.000
#   11.000
#
# la pila se inicia con el primer elemento igual a 0
# la pila puede contener cualquier valor float IEEE754
# por lo que se puede tener "inf"("50 50 p ")
#
# la pila indica error de rango de stack, evitando la
# escritura en lugares no permitidos, en estos casos se
# recomienda reinicializar pila con ("c")
#
# se deja abierta la posibilidad de agregar un metodo para ver todos los
# elementos de la pila(resultaria util antes de tener que
# reinicializar pila por ejemplo)
#
# El hecho de utilizar una pila propia y no el stack, es para no
# interferir con el proposito del stack ($sp) de almacenar valores
# durante la ejecucion de procedimientos, se ha decidido mantener ese
# unico proposito para el stack en este proyecto.
#
# En cada llamado a apilar o desapilar de la pila, se puede generar
# un error que se indica con $v1 = 1($v1 = 0 si no hay error), por lo que
# despues de los llamados a estas funciones se realiza un chequeo de error.
