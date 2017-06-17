# Universidad de Costa Rica
# Escuela de Ingeniería Eléctrica
# Estructuras de Computadoras Digitales I - IE0321
# Tarea 8
# Emilio Javier Rojas Álvarez - B15680
#

# Este programa solicita 3 posibles lados para
# un triángulo, identifica si es posible crear
# el triángulo con los lados dados. En caso de
# no serlo, se indica al usuario, y se solicitan
# nuevamente los lados. En caso de ser posible
# crear el triangulo, se indican sus siguentes
# proppiedades:
#   - Perímetro
#   - Tipo
#   - Área
#   - Altura lado 1
#   - Altura lado 2
#   - Altura lado 3

# datos del programa
.data
  # se guardan 12 bytes (3 palabras) para los enteros ingresados
  triangulo: .space 12
  .align 2

  # el tipo del triangulo se guarda como una direccion
  # al correspondiente tipo de triangulo
  texto_tipo_equilatero:
    .asciiz "Equilátero\n"
  texto_tipo_isosceles:
    .asciiz "Isósceles\n"
  texto_tipo_escaleno:
    .asciiz "Escaleno\n"

    # Textos
    texto_error_triangulo:
        .asciiz "No se puede formar un triángulo con los lados dados.
Intentelo de nuevo."

      texto_solicitar_lado_triangulo_1:
        .asciiz "Ingresar lado 1 del triángulo:\n"

      texto_solicitar_lado_triangulo_2:
        .asciiz "Ingresar lado 2 del triángulo:\n"

      texto_solicitar_lado_triangulo_3:
        .asciiz "Ingresar lado 3 del triángulo:\n"

      texto_solicitar_lado_triangulo_error_negativo:
        .asciiz "El lado del triangulo debe ser positivo\n"

    texto_lado_1:    .asciiz "Lado 1 . . . . . . "
    texto_lado_2:    .asciiz "Lado 2 . . . . . . "
    texto_lado_3:    .asciiz "Lado 3 . . . . . . "
    texto_perimetro: .asciiz "Perímetro  . . . . "
    texto_tipo:      .asciiz "Tipo . . . . . . . "
    texto_area:      .asciiz "Área . . . . . . . "
    texto_altura_1:  .asciiz "Altura lado 1  . . "
    texto_altura_2:  .asciiz "Altura lado 2  . . "
    texto_altura_3:  .asciiz "Altura lado 3  . . "
    texto_unidades_lineal: .asciiz " ul"
    texto_unidades_cuadrado: .asciiz " ul^2"

    # linea horizontal
    texto_hr: .asciiz "----------------------------------------------\n"

    texto_instricciones: .asciiz "Este programa solicita 3 posibles lados para
un triángulo, identifica si es posible crear
el triángulo con los lados dados. En caso de
no serlo, se indica al usuario, y se solicitan
nuevamente los lados. En caso de ser posible
crear el triangulo, se indican sus siguentes
proppiedades:
  - Perímetro
  - Tipo
  - Área
  - Altura lado 1
  - Altura lado 2
  - Altura lado 3
"

.text
main:
  # se muestran unicamente una vez las instrucciones al inicio del programa
  instrucciones:
    la $a0, texto_instricciones
    jal imprimir_asciiz

  inicio:
    # linea de separacion
    la $a0, texto_hr
    jal imprimir_asciiz

    # solicitar lados al usuario
    jal obtener_lados_triangulo
    # guarda lados en triangulo

    # chequear si se puede formar triangulo
    la $v0, triangulo
    jal desigualdad_triangular # $v0 = 1 si hay triangulo
    beq $v0, $zero, error_triangulo

    # calcular las propiedades del triangulo
    jal propiedades_triangulo

    # impresiones

    # lados
    la $s7 triangulo
    la $a0, texto_lado_1
    jal imprimir_asciiz
    lw $a0, 0($s7)
    jal imprimir_int
    la $a0, texto_unidades_lineal
    jal imprimir_asciiz
    jal newline

    la $a0, texto_lado_2
    jal imprimir_asciiz
    lw $a0, 4($s7)
    jal imprimir_int
    la $a0, texto_unidades_lineal
    jal imprimir_asciiz
    jal newline

    la $a0, texto_lado_3
    jal imprimir_asciiz
    lw $a0, 8($s7)
    jal imprimir_int
    la $a0, texto_unidades_lineal
    jal imprimir_asciiz
    jal newline

    # tipo
    la $a0, texto_tipo
    jal imprimir_asciiz
    move $a0, $s1
    jal imprimir_asciiz

    # perimetro
    la $a0, texto_perimetro
    jal imprimir_asciiz
    move $a0, $s0
    jal imprimir_int
    la $a0, texto_unidades_lineal
    jal imprimir_asciiz
    jal newline

    # area
    la $a0, texto_area
    jal imprimir_asciiz
    mov.s $f12, $f0
    jal imprimir_float
    la $a0, texto_unidades_cuadrado
    jal imprimir_asciiz
    jal newline

    # altura lado 1
    la $a0, texto_altura_1
    jal imprimir_asciiz
    mov.s $f12, $f1
    jal imprimir_float
    la $a0, texto_unidades_lineal
    jal imprimir_asciiz
    jal newline

    # altura lado 2
    la $a0, texto_altura_2
    jal imprimir_asciiz
    mov.s $f12, $f2
    jal imprimir_float
    la $a0, texto_unidades_lineal
    jal imprimir_asciiz
    jal newline

    # altura lado 3
    la $a0, texto_altura_3
    jal imprimir_asciiz
    mov.s $f12, $f3
    jal imprimir_float
    la $a0, texto_unidades_lineal
    jal imprimir_asciiz
    jal newline
    jal newline

    j inicio # solicitar lados nuevamente

    addiu $v0, $zero, 10
    syscall

    error_triangulo:
      la $a0, texto_error_triangulo
      jal imprimir_asciiz
      jal newline
      j inicio # solicitar lados nuevamente
