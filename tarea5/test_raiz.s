
# tests
test_raiz:
  addiu $sp, $sp, -4
  sw $ra, 0($sp)

  la $a0, raiz_test_inicio
  jal imprimir_asciiz

  lwc1 $f0, raiz_test_float1
  jal single_test_raiz
  lwc1 $f0, raiz_test_float2
  jal single_test_raiz
  lwc1 $f0, raiz_test_float3
  jal single_test_raiz
  lwc1 $f0, raiz_test_float4
  jal single_test_raiz
  lwc1 $f0, raiz_test_float5
  jal single_test_raiz
  lwc1 $f0, raiz_test_float6
  jal single_test_raiz
  lwc1 $f0, raiz_test_float7
  jal single_test_raiz
  lwc1 $f0, raiz_test_float8
  jal single_test_raiz

  la $a0, raiz_test_fin
  jal imprimir_asciiz

  lw $ra, 0($sp)
  addiu $sp, $sp, 4
  jr $ra

single_test_raiz:
  addiu $sp, $sp, -4
  sw $ra, 0($sp)

  jal raiz
  mov.s $f12, $f1
  jal imprimir_float
  jal newline

  lw $ra, 0($sp)
  addiu $sp, $sp, 4
  jr $ra
