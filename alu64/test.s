.data
  check_sum_1: .asciiz "check $t0, $t1 for sum 1"
  check_2scomp_1: .asciiz "check $t0, $t1 for 2s comp 1"
  check_sub_1: .asciiz "check $t0, $t1 for sub 1"
  texto_newline: .asciiz "\n"
.text
main:
  test_sum64_1:
    li $a0, 0xfffff
    li $a1, 0xfffff
    li $a2, 0xfffff
    li $a3, 0xffffffff
    jal sum64

    move $s0, $v0
    move $s1, $v1

    # print hex result, should be
    # 0x001fffff
    # 0x000ffffe
    # http://www.miniwebtool.com/hex-calculator/?number1=fffff000fffff&operate=1&number2=fffffffffffff

    li $v0, 34 # print hex
    move $a0, $s0
    syscall

    jal newline

    li $v0, 34 # print hex
    move $a0, $s1
    syscall

    jal newline

  test_twoscomplement64_1:
    li $a0, 0x0
    li $a1, 0x1
    jal twoscomplement64

  test_sub64_1:
    li $a0, 0x0
    li $a1, 0x14
    li $a2, 0x0
    li $a3, 0x5
    jal sub64

  test_sll64_1:
  test_srl64_1:
  exit:
    addi $v0, $zero, 10
    syscall

  # imprime un caracter newline (\n)
  newline:
    move $t1, $a0
    move $t2, $v0
    li $v0, 4
    la $a0, texto_newline
    syscall
    move $a0, $t1
    move $v0, $t2
    jr $ra
