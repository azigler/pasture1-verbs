#71:moveit   this none this rxd

"Wizardly verb to move object with requestor's permission";
if (caller != this)
  return E_PERM;
else
  set_task_perms(player = args[3]);
  return args[1]:moveto(args[2]);
endif
