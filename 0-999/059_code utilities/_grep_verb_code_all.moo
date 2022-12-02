#59:_grep_verb_code_all   this none this rxd

":_grep_verb_code_all(pattern,object,verbname[,casematters]) => list of lines";
"  returns list of lines on which pattern occurs in code for object:verbname";
set_task_perms(caller_perms());
{pattern, object, vname, ?casematters = 0} = args;
lines = {};
for line in (vc = `verb_code(object, vname) ! ANY => {}')
  if (index(line, pattern, casematters))
    lines = {@lines, line};
  endif
endfor
return lines;
