.align 2
.text

# main
#
# metodo main se ejecuta al inicio del programa
main:
  # label del inicio del programa
  la $a0, texto_bienvenida
  jal imprimir_asciiz
  la $a0, texto_uso
  jal imprimir_asciiz
  inicio:

    # # tests varios se encuentran en tests_programa_rpn
    # jal tests_programa_rpn

    jal rpn_stack_iniciar # se inicia la pila para el rpn
    li.s $f0, 0,0
    jal rpn_apilar # se carga valor inicial 0
    programa_usuario:
      la $a0, texto_solicitud_instruccion
      jal imprimir_asciiz

      jal solicitud_string # string comienza en $a0

      jal len_string # longitud del string en $a0
      move $a1, $v0

      # le entra
      #   $a0 la direccion de inicio del string
      #   $a1 la longitud del string
      jal rpn

    reiniciar:
      j programa_usuario

    # nunca se llega acá, pero parece adecuado tener esta etiqueta
    # sirve para probar cosas sin pasar por programa_usuario
    fin:
      addi $v0, $zero, 10
      syscall
