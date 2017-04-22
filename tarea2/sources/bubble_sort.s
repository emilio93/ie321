# bubble_sort
#
# $a0 : (A) direccion que apunta a A
# $a1 : (len) cantidad de elementos en A
bubble_sort:
  addi $sp, $sp, -24
  sw $ra, 0($sp)
  sw $a0, 4($sp)
  sw $a1, 8($sp)
  sw $s0, 12($sp)
  sw $s1, 16($sp)
  sw $s2, 20($sp)

  # n = len
  # n = $s0
  add $s0, $zero, $a1

# bSort_while
#
# codigo dentro del do ... while (n>0)
# n es el indice del ultimo numero que se debe hacer swap
# n es el indice del primer numero ultimo par al cual se le aplicó un swap
bSort_while:

  # sigN = 0
  # sigN = $s1
  addi $s1, $zero, 0

  # i = 0
  # i = $s2
  addi $s2, $zero, 0

bSort_sort:

  # $t0 = $a1 - 1
  # $t0 = len - 1
  addi $t0, $a1, -1

  # if i => (len-1), end for
  bge $s2, $t0, bSort_while_check

  sll $t0, $s2, 2 # i*4
  add $t0, $t0, $a0 # indice actual
  lw $t1, 4($t0) # a[i+1]
  lw $t2, 0($t0) # a[i]

  add $a3, $zero, $t0
  ble $t1, $t2, bSort_noswap # noswap

  bSort_swap:
    lw $t0, 0($a3) # $t0 = a[i]
    lw $t1, 4($a3) # $t1 = a[i+1]
    sw $t0, 4($a3) # a[i] = $t1
    sw $t1, 0($a3) # a[i+1] = $t0
    addi $s1, $s2, 1 # sigN = i + 1

  bSort_noswap:
    addi $s2, $s2, 1
    j bSort_sort

# bSort_while_check
# se mantiene en el while  mientras n($s0) != 0
bSort_while_check:
  add $s0, $zero, $s1 # n = sigN
  bne $zero, $s0, bSort_while # if n != 0 then bSort_while

# bSort_exit
# se recupera los registros guardados en el stack
# se libera el espacio en el stack
# se regresa a $ra
bSort_exit:
  lw $ra, 0($sp)
  lw $a0, 4($sp)
  lw $a1, 8($sp)
  lw $s0, 12($sp)
  lw $s1, 16($sp)
  lw $s2, 20($sp)
  addi $sp, $sp, 24
  jr $ra
