#59:set_verb_documentation   this none this rxd

":set_verb_documentation(object,verbname,text)";
"  changes documentation at beginning of verb code";
"  text is either a string or a list of strings";
"  returns a non-1 value if anything bad happens...";
set_task_perms(caller_perms());
{object, vname, text} = args;
if (typeof(code = `verb_code(object, vname) ! ANY') == ERR)
  return code;
elseif (typeof(vd = $code_utils:verb_documentation(object, vname)) == ERR)
  return vd;
elseif (!(typeof(text) in {LIST, STR}))
  return E_INVARG;
else
  newdoc = {};
  for l in (typeof(text) == LIST ? text | {text})
    if (typeof(l) != STR)
      return E_INVARG;
    endif
    newdoc = {@newdoc, $string_utils:print(l) + ";"};
  endfor
  if (ERR == typeof(svc = `set_verb_code(object, vname, {@newdoc, @code[length(vd) + 1..$]}) ! ANY'))
    "... this shouldn't happen.  I'm not setting this code -d just yet...";
    return svc;
  else
    return 1;
  endif
endif
