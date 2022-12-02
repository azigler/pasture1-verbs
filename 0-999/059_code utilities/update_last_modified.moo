#59:update_last_modified   this none this xd

perms = caller == $verb_editor || (perms = caller_perms()).wizard ? player | perms;
"usual callers are $verb_editor:compile and $prog:@program";
set_task_perms(perms);
object = args[1];
verbname = args[2];
oldcode = code = verb_code(object, verbname);
code = this:remove_last_modified_lines(code);
timestamp = ctime();
code = {@code, tostr("\"Last modified ", timestamp, " by ", $string_utils:nn(player), ".\";")};
set_verb_code(object, verbname, code);
return oldcode == verb_code(object, verbname);
