#3:remove_entrance   this none this rxd

exit = args[1];
if (caller != exit)
  set_task_perms(caller_perms());
endif
return `this.entrances = setremove(this.entrances, exit) ! E_PERM' != E_PERM;
