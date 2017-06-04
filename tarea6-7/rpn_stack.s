# Estas dos funciones se hacen cargo de apilar y desapilar
# del espacio rpn_stack
#
# elemento 0 del stack es contador(o indice del ultimo elemento)
# expresado como la direccion del ultimo elemento

rpn_stack_iniciar:
  la $t0, rpn_stack
  # se inicia contador en direccion 1 de rpn_stack
  addiu $v0, $t0, 4
  sw $v0, 0($t0)
  jr $ra

#
# chequea espacio y actualiza direccion al siguiente elemento
# devuelve direccion actualizada en $v0
# $v1 es 1 si se dio un error, 0 en caso contrario
rpn_stack_incrementar:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  addi $v1, $zero, 0 # se asume que no hay error

  la $t0, rpn_stack
  lw $v0, 0($t0)
  la $t1, max_rpn_len
  lw $t1, 0($t1)
  addu $t1, $t1, $t0
  addi $t1, $t1, -4
  bgt $v0, $t1, rpn_stack_error_superior # se chequea que no sea mayor que el
                                         # ultimo indice dado para el stack
  addiu $v0, $v0, 4 # se incrementa en 4 el contador
  sw $v0, 0($t0) # se guarda el contador solo si esta en el rango
  j rpn_stack_incrementar_fin
  rpn_stack_error_superior:
    jal rpn_stack_error
  rpn_stack_incrementar_fin:
    lw $ra, 0($sp)
    addiu $sp, $sp, 4
    jr $ra

#
# chequea espacio y actualiza direccion al elemento previo
# devuelve direccion actualizada en $v0
# $v1 es 1 si se dio un error, 0 en caso contrario
rpn_stack_decrementar:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  addi $v1, $zero, 0 # se asume que no hay error

  la $t0, rpn_stack
  lw $v0, 0($t0)
  addi $v0, $v0, -4 # se decrementa en 4 el contador
  ble $v0, $t0, rpn_stack_error_inferior # se chequea que no sea ni la direccion del
                                # contador o menor
  sw $v0, 0($t0) # se guarda el contador solo si la direccion esta en el rango
  j rpn_stack_decrementar_fin
  rpn_stack_error_inferior:
    jal rpn_stack_error

  rpn_stack_decrementar_fin:
    lw $ra, 0($sp)
    addiu $sp, $sp, 4
    jr $ra

# apila $f0 en rpn_stack
rpn_apilar:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  jal rpn_stack_incrementar # chequeo de espacio
  s.s $f0, -4($v0) # se apila

  lw $ra, 0($sp)
  addiu $sp, $sp, 4
  jr $ra

# desapila ultimo elemento de rpn_stack y lo devuelve en $f0
rpn_desapilar:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  jal rpn_stack_decrementar # chequeo de espacio
  l.s $f0, 0($v0) # se obtiene

  lw $ra, 0($sp)
  addiu $sp, $sp, 4
  jr $ra

# obtiene ultimo elemento de rpn_stack y lo devuelve en $f0
rpn_ver:
  la $t0, rpn_stack
  lw $t1, 0($t0) # direccion de elemento siguiente
  addi $t1, $t1, -4
  l.s $f0, 0($t1) # se obtiene en $f0
  jr $ra

# stack se salio del rango
rpn_stack_error:
  addi $sp, $sp, -4
  sw $ra, 0($sp)

  la $a0, texto_rpn_stack_error
  jal imprimir_asciiz
  addiu $v1, $zero, 1 # se indica error

  lw $ra, 0($sp)
  addiu $sp, $sp, 4

  # regresar a ejecucion del programa
  jr $ra

  # comentar linea anterior para finalizar ejecucion en
  # caso de error en direccion de la pila
  addiu $v0, $zero, 10
  syscall # finalizar ejecucion
  jr $ra
