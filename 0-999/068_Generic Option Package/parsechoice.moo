#68:parsechoice   this none this rxd

":parsechoice(oname,rawval,assoclist)";
which = {};
oname = args[1];
rawval = args[2];
choices = $list_utils:slice(args[3], 1);
errmsg = tostr("Allowed values for this flag: ", $string_utils:english_list(choices, "(??)", " or "));
if (typeof(rawval) == LIST)
  if (length(rawval) > 1)
    return errmsg;
  endif
  rawval = rawval[1];
elseif (typeof(rawval) != STR)
  return errmsg;
endif
for c in (choices)
  if (index(c, rawval) == 1)
    which = {@which, c};
  endif
endfor
if (!which)
  return errmsg;
elseif (length(which) > 1)
  return tostr(rawval, " is ambiguous.");
else
  return {oname, which[1]};
endif
