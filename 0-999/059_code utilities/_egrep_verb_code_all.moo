#59:_egrep_verb_code_all   this none this rxd

":_egrep_verb_code_all(regexp,object,verbname[,casematters]) => list of lines number";
"  returns list of all lines matching regexp in object:verbname code";
set_task_perms(caller_perms());
{pattern, object, vname, ?casematters = 0} = args;
lines = {};
for line in (vc = `verb_code(object, vname, 1, 0) ! ANY => {}')
  if (match(line, pattern, casematters))
    lines = {@lines, line};
  endif
endfor
return lines;
