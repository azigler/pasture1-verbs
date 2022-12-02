#3:remove_exit   this none this rxd

exit = args[1];
if (caller != exit)
  set_task_perms(caller_perms());
endif
return `this.exits = setremove(this.exits, exit) ! E_PERM' != E_PERM;
