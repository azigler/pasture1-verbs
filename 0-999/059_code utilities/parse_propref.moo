#59:parse_propref   this none this rxd

"$code_utils:parse_propref(string)";
"Parses string as a MOO-code property reference, returning {object-string, prop-name-string} for a successful parse and false otherwise.  It always returns the right object-string to pass to, for example, this-room:match_object.";
s = args[1];
if (dot = index(s, "."))
  object = s[1..dot - 1];
  prop = s[dot + 1..$];
  if (object == "" || prop == "")
    return 0;
  elseif (object[1] == "$")
    ob = `#0.(object[2..$]) ! ANY';
    if (typeof(ob) != OBJ)
      "Try a map...";
      ob = $code_utils:parse_sysobj_map(object);
    endif
    if (typeof(ob) != OBJ)
      return 0;
    endif
    object = tostr(ob);
  endif
elseif (index(s, "$") == 1)
  object = "#0";
  prop = s[2..$];
else
  return 0;
endif
return {object, prop};
