#3:add_exit   this none this rxd

set_task_perms(caller_perms());
return `this.exits = setadd(this.exits, args[1]) ! E_PERM' != E_PERM;
