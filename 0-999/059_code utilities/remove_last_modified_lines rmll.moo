#59:"remove_last_modified_lines rmll"   this none this xd

perms = caller == $verb_editor || (perms = caller_perms()).wizard ? player | perms;
"usual caller is $verb_editor:compile";
set_task_perms(perms);
code = args[1];
if (typeof(code) != LIST)
  raise(E_INVARG);
endif
for line in (code)
  yin(0);
  if (length(line) >= 15 && line[1..15] == "\"Last modified ")
    code = code:remove(line);
  endif
endfor
return code;
