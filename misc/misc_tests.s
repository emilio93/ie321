
.data

  # Titulos
  impresion_test_respuesta_mayor_a_cero: .asciiz "test_respuesta_mayor_a_cero"
  impresion_no_infinito: .asciiz "test_no_infinito"
  impresion_test_min_int: .asciiz "test_min_int"
  impresion_test_max_int: .asciiz "test_max_int"
  impresion_test_len_string: .asciiz "test_len_string"
  impresion_test_is_byte_int: .asciiz "test_is_byte_int"
  impresion_test_solicitud_int: .asciiz "test_solicitud_int"
  impresion_test_solicitud_float: .asciiz "test_solicitud_float"
  impresion_test_solicitud_string: .asciiz "test_solicitud_string"
  impresion_test_bytes_a_float: .asciiz "test_bytes_a_float"

.text
main:
  j test_bytes_a_float
  test_misc:
    test_respuesta_mayor_a_cero:
      la $a0, impresion_test_respuesta_mayor_a_cero
      jal imprimir_asciiz
      jal newline

      li.s $f0, 1,0
      jal respuesta_mayor_a_cero
      addu $a0, $zero, $v0
      jal imprimir_int # debe ser 1
      jal newline

      li.s $f0, 0,0
      jal respuesta_mayor_a_cero
      addu $a0, $zero, $v0
      jal imprimir_int # debe ser 0
      jal newline

      li.s $f0, -1,0
      jal respuesta_mayor_a_cero
      addu $a0, $zero, $v0
      jal imprimir_int # debe ser 0
      jal newline
    test_no_infinito:
      la $a0, impresion_no_infinito
      jal imprimir_asciiz
      jal newline

      li.s $f0, 10000000,0

      li.s $f1, 1000000000000000000000000000000000,0
      mul.s $f0, $f0, $f1

      mov.s $f12, $f0
      jal imprimir_float # multiplicacion muy grande da inf
      jal newline

      jal no_infinito
      addu $a0, $zero, $v0
      jal imprimir_int # deberia imprimir 1
      jal newline
    test_min_int:
      la $a0, impresion_test_min_int
      jal imprimir_asciiz
      jal newline

      li $a0, 5
      li $a1, 3
      jal min_int
      move $a0, $v0
      jal imprimir_int # deberia ser 3
      jal newline
    test_max_int:
      la $a0, impresion_test_max_int
      jal imprimir_asciiz
      jal newline

      li $a0, 5
      li $a1, 3
      jal max_int
      move $a0, $v0
      jal imprimir_int # deberia ser 5
      jal newline

      li $a0, 7
      li $a1, 7
      jal max_int
      move $a0, $v0
      jal imprimir_int # deberia ser 7
      jal newline
    test_len_string:
      la $a0, impresion_test_len_string
      jal imprimir_asciiz
      jal newline

      .data
        dato_len_string: .asciiz "123456789"
      .text
      la $a0, dato_len_string
      jal len_string
      move $a0, $v0
      jal imprimir_int # deberia imprimir 9
      jal newline
    test_is_byte_int:
      la $a0, impresion_test_is_byte_int
      jal imprimir_asciiz
      jal newline

      li $a0, 5
      jal is_byte_int
      move $a0, $v0
      jal imprimir_int # deberia imprimir 0, no es numero
      jal newline
      move $a0, $v1
      jal imprimir_int # deberia imprimir 0, no es numero
      jal newline

      li $a0, 54
      jal is_byte_int
      move $a0, $v0
      jal imprimir_int # deberia imprimir 1, es numero
      jal newline
      move $a0, $v1
      jal imprimir_int # deberia imprimir numero(6 = 54-48)
      jal newline

  test_lectura:
    test_solicitud_int:
      la $a0, impresion_test_solicitud_int
      jal imprimir_asciiz
      jal newline

      .data
        dato_solicitud_int1: .asciiz "ingresar int\n"
        dato_solicitud_int2: .asciiz "ingresó: "
      .text
      la $a0, dato_solicitud_int1
      jal imprimir_asciiz

      jal solicitud_int
      jal newline
      la $a0, dato_solicitud_int2
      jal imprimir_asciiz
      move $a0, $v0
      jal imprimir_int
      jal newline


    test_solicitud_float:
      la $a0, impresion_test_solicitud_float
      jal imprimir_asciiz
      jal newline

      .data
        dato_solicitud_float1: .asciiz "ingresar float\n"
        dato_solicitud_float2: .asciiz "ingresó: "
      .text
      la $a0, dato_solicitud_float1
      jal imprimir_asciiz

      jal solicitud_float
      jal newline
      la $a0, dato_solicitud_float2
      jal imprimir_asciiz
      mov.s $f12, $f0
      jal imprimir_float
      jal newline

    test_solicitud_string:
      la $a0, impresion_test_solicitud_string
      jal imprimir_asciiz
      jal newline

      .data
        dato_solicitud_string1: .asciiz "ingresar string\n"
        dato_solicitud_string2: .asciiz "ingresó: "
        input_string: .space 128
        input_max_len: .word 128
      .text
      la $a0, dato_solicitud_string1
      jal imprimir_asciiz

      jal solicitud_string
      move $s0, $a0
      jal newline
      la $a0, dato_solicitud_string2
      jal imprimir_asciiz
      move $a0, $s0
      jal imprimir_asciiz
      jal newline

    test_bytes_a_float:
      la $a0, impresion_test_bytes_a_float
      jal imprimir_asciiz
      jal newline

      .data
        dato_bytes_a_float1: .asciiz "1,5365546452"
        dato_bytes_a_float2: .asciiz "1.54"
        dato_bytes_a_float3: .asciiz "-1.54"
        dato_bytes_a_float4: .asciiz "1"
        dato_bytes_a_float5: .asciiz ",05"
      .text

      la $a0, dato_bytes_a_float1
      jal bytes_a_float
      mov.s $f12, $f0
      jal imprimir_float
      jal newline

      move $a0, $v0
      jal imprimir_int
      jal newline


      la $a0, dato_bytes_a_float2
      jal bytes_a_float
      mov.s $f12, $f0
      jal imprimir_float
      jal newline

      move $a0, $v0
      jal imprimir_int
      jal newline

      la $a0, dato_bytes_a_float3
      jal bytes_a_float
      mov.s $f12, $f0
      jal imprimir_float

      jal newline

      move $a0, $v0
      jal imprimir_int

      jal newline

      la $a0, dato_bytes_a_float4
      jal bytes_a_float
      mov.s $f12, $f0
      jal imprimir_float

      jal newline

      move $a0, $v0
      jal imprimir_int

      jal newline

      la $a0, dato_bytes_a_float5
      jal bytes_a_float
      mov.s $f12, $f0
      jal imprimir_float

      jal newline

      move $a0, $v0
      jal imprimir_int

  li $v0, 10
  syscall
