#118:new   this none this rxd

"WIZARDLY";
set_task_perms(caller_perms());
player = caller_perms();
w = new_waif();
w:initialize(@args);
return w;
