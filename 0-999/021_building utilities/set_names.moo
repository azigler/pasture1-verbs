#21:set_names   this none this rxd

"$building_utils:set_names(object, spec)";
set_task_perms(caller_perms());
object = args[1];
names = this:parse_names(args[2]);
name = names[1] || object.name;
return object:set_name(name) && object:set_aliases(names[2]);
