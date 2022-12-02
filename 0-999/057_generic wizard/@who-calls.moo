#57:@who-calls   any any any rd

set_task_perms(player);
if (argstr[1] != ":")
  argstr = ":" + argstr;
endif
player:notify(tostr("Searching for verbs that appear to call ", argstr, " ..."));
player:notify("");
$code_utils:find_verbs_containing(argstr + "(");
