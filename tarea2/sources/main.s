main:
  la $a0, Data
  la $a1, Length
  lw $a1, 0($a1)
  jal print_data

  add $v1, $a0, $zero
  li $v0, 4
  la $a0, newline
  syscall
  add $a0, $v1, $zero

  jal bubble_sort

  add $v1, $a0, $zero
  li $v0, 4
  la $a0, newline
  syscall
  add $a0, $v1, $zero

  # terminar ejecucion del progama
  li $v0, 10
  syscall
