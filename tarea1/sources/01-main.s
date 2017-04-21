
# main
#
# metodo main se ejecuta al inicio dl programa
main:
  # label del inicio del programa
  inicio:
    # mostrar texto de solicitud de entero
    addi $v0, $zero,  4 # print string
    la $a0, texto_solicitud
    syscall

  # label para la solicitud del entero n
  solicitud:
    addi $v0, $zero, 5
    syscall

    # comprobar rango de numero, solicitar nuevamente si no esta en el rango
    addi $t0, $zero, 45
    bge    $v0, $t0, print_error_numero_alto  # if $v0 >= $t0 then print_error_numero_alto
    ble    $v0, $zero, print_error_numero_bajo  # if $v0 <= $zero then print_error_numero_bajo

  # label para la impresion del resultado
  print_texto:
    add $t0, $zero, $v0
    addi $v0, $zero,  4 # print string
    la $a0, texto_respuesta
    syscall
    add $a0, $zero, $t0

    jal fibonacci

    # dejar cursor de consola en una linea limpia
    addi $v0, $zero,  4 # print string
    la $a0, newline
    syscall

    # regresar al inicio del programa
    j inicio

    # terminar ejecucion del progama
    li $v0, 10
    syscall
