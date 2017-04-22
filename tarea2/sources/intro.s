# Universidad de Costa Rica
# Escuela de Ingeniería Eléctrica
# Estructuras de Computadoras Digitales I - IE0321
# Tarea 2
# Emilio Javier Rojas Álvarez - B15680
#
# Se implementa el siguiente codigo(javascript) en mips
# para ordenar un arreglo dado, segun el algoritmo
# bubble sort
#
# Se anotan las diferentes secciones que se encuentran
# en el codigo mips
#
#  this.arr = [1,2,3,8,4,5,6,7];
#  this.sort = () => {
#     // buuble_sort
#     let n = this.arr.length;
#     // bSort_while
#     do {
#         this.sigN = 0;
#         // bSort_sort
#         for (this.i = 0; this.i < (this.arr.length - 1); this.i++)
#             if (this.arr[this.i] < this.arr[this.i+1]) {
#                 // bSort_swap
#                 let ival = this.arr[this.i];
#                 let jval = this.arr[this.i+1];
#                 this.arr[this.i] = jval;
#                 this.arr[this.i+1] = ival;
#                 this.sigN = this.i + 1;
#             }
#             // bSort_noswap
#         n = this.sigN;
#     } while (n > 0);
#     return this.arr;
# };
#

.text
