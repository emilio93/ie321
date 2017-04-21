
# exit_fibonacci
#
# finaliza la ejecucion del procedimiento fibonacci
exit_fibonacci:
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  add $v0, $zero, $t1
  jr $ra
