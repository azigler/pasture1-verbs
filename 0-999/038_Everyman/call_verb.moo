#38:call_verb   this none this rxd

"call_verb(object, verb name, args)";
"Call verb with $no_one's permissions (so you won't damage anything).";
"One could do this with $no_one:eval, but ick.";
set_task_perms(this);
return args[1]:(args[2])(@args[3]);
