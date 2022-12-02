#57:"@rn mail_catch_up check_mail_lists current_message set_current_message get_current_message make_current_message kill_current_message @nn"   none none none rxd

if (caller != this)
  set_task_perms(valid(caller_perms()) ? caller_perms() | player);
endif
use = this.mail_identity;
if (valid(use) && use != this)
  return use:(verb)(@args);
else
  return pass(@args);
endif
