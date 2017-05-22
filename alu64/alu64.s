
# Emilio Rojas 2017
#
# ALU 64
# mimics a 64bit alu's operations
#   - sum64: sum
#   - twoscomplement64: twos complement
#   - sub64: substraction
#   - sll64: switch left logical
#   - srl64: switch right logical

# sum64
#
# does ($a0 $a1) + ($a2 $a3) = ($v0 $v1)
# each being a 64 bit [pseudo] register
sum64:
  addu $v1, $a1, $a3 # sum lower registers into $v1
  sltu $v0, $v1, $a3 # check overflow in lower registers
  addu $v0, $v0, $a0 # sum overflow (either 0 or 1) with $a0 into $v0
  addu $v0, $v0, $a2 # sum current upper register with $a2 to get final
                     # upper register result into $v0
  jr $ra

# twoscomplement64
#
# gets twos complement of $a0 $a1 in $v0 $v1
#
# quick reminder
# twos complement of A is A'+1
twoscomplement64:
  # negate
  li $t0, 0xffffffff # 32 bit mask 111...111
  xor $t1, $t0, $a0 # xor toggles, ie negates upper register
  xor $t2, $t0, $a1 # xor toggles, ie negates lower register
  # sum 1
  addiu $v1, $t2, 1
  # check carry bit
  sltiu $v0, $v1, 1
  addu $v0, $v0, $t1 # sum overflow
  jr $ra

# sub64
#
# does $a0 $a1 - $a2 $a3 = $v0 $v1
#
# quick reminder
# A - B = (A'+1) + B
sub64:
  # save registers in stack
  addiu $sp, $sp, -12
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)

  # load arguments $a0 and $a1 with $a2 and $a3
  move $a0, $a2
  move $a1, $a3

  # get its twos complement
  jal twoscomplement64

  move $a2, $v0
  move $a3, $v1

  # restore values to $a0 and $a1
  lw $a0, 4($sp)
  lw $a1, 8($sp)

  # sum $a0 $a1 + twoscomplement64($a2 $a3)
  jal sum64

  # restore values saved in stack
  lw $ra, 0($sp)
  addiu $sp, $sp, 12
  jr $ra

# sll64
#
# switch left logical $a0 $a1 in $v0 $v1
# also $s0 indicates overflow so DO KEEP $s0 IF NEEDED
sll64:
  # first check overflow, so $a0's MSB shouldn't be 1
  addiu $s0, $zero, 0
  srl $t0, $a0, 31
  beq $t0, $zero, sll64_nooverflow
  addiu $s0, $zero, 1

  # always execute, only a label to jump to if no overflow
  sll64_nooverflow:
  sll $v0, $a0, 1
  sll $v1, $a1, 1
  srl $t0, $a1, 31
  or $v0, $t0, $v0
  jr $ra

# srl64
#
# switch right logical $a0 $a1 in $v0 $v1
srl64:
  srl $v0, $a0, 1
  srl $v1, $a1, 1
  and $t0, $a0, 1
  sll $t0, $t0, 31
  or $v1, $t0, $v1
  jr $ra
