#59:_grep_verb_code   this none this rxd

":_grep_verb_code(pattern,object,verbname[,casematters]) => line number or 0";
"  returns line number on which pattern occurs in code for object:verbname";
set_task_perms(caller_perms());
{pattern, object, vname, ?casematters = 0} = args;
"The following gross kluge is due to Quade (#82589).  tostr is fast, and so we can check for nonexistence of a pattern very quickly this way rather than checking line by line.  MOO needs a compiler.  --Nosredna";
vc = `verb_code(object, vname) ! ANY';
if (typeof(vc) == ERR || !index(tostr(@vc), pattern, casematters))
  return 0;
else
  for line in (vc)
    if (index(line, pattern, casematters))
      return line;
    endif
  endfor
  return 0;
endif
