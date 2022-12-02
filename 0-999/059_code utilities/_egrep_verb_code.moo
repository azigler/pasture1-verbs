#59:_egrep_verb_code   this none this rxd

":_egrep_verb_code(regexp,object,verbname[,casematters]) => 0 or line number";
"  returns line number of first line matching regexp in object:verbname code";
set_task_perms(caller_perms());
{pattern, object, vname, ?casematters = 0} = args;
try
  for line in (vc = `verb_code(object, vname) ! ANY => {}')
    if (match(line, pattern, casematters))
      return line;
    endif
  endfor
except (E_INVARG)
  raise(E_INVARG, "Malformed regular expression.");
endtry
return 0;
