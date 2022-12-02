#59:parse_verbref   this none this rxd

"$code_utils:parse_verbref(string)";
"Parses string as a MOO-code verb reference, returning {object-string, verb-name-string} for a successful parse and false otherwise.  It always returns the right object-string to pass to, for example, this-room:match_object().";
s = args[1];
if (colon = index(s, ":"))
  object = s[1..colon - 1];
  verbname = s[colon + 1..$];
  if (!(object && verbname))
    return 0;
  elseif (object[1] == "$")
    pname = object[2..$];
    if (!(pname in properties(#0)) || typeof(ob = #0.(pname)) != OBJ)
      "Try a map...";
      ob = $code_utils:parse_sysobj_map(object);
    endif
    if (typeof(ob) != OBJ)
      return 0;
    endif
    object = tostr(ob);
  endif
  return {object, verbname};
elseif (index(s, "$") == 1 && !index(s, "."))
  return {"#0", s[2..$]};
else
  return 0;
endif
