#20:_toscalar   this none this rxd

":_toscalar(string)  --- auxiliary for :tovalue";
" => value if string represents a number, object or error";
" => string error message otherwise";
thing = args[1];
if (!thing)
  return "missing value";
elseif (match(thing, "^#?[-+]?[0-9]+ *$"))
  return thing[1] == "#" ? toobj(thing) | toint(thing);
elseif (match(thing, "^[-+]?%([0-9]+%.[0-9]*%|[0-9]*%.[0-9]+%)%(e[-+]?[0-9]+%)? *$"))
  "matches 2. .2 3.2 3.2e3 .2e-3 3.e3";
  return `tofloat(thing) ! E_INVARG => tostr("Bad floating point value: ", thing)';
elseif (match(thing, "^[-+]?[0-9]+e[-+]?[0-9]+ *$"))
  "matches 345e4. No decimal, but has an e so still a float";
  return `tofloat(thing) ! E_INVARG => tostr("Bad floating point value: ", thing)';
elseif (thing == "true")
  return true;
elseif (thing == "false")
  return false;
elseif (thing[1] == "E")
  return (e = $code_utils:toerr(thing)) ? tostr("unknown error code `", thing, "'") | e;
elseif (thing[1] == "#")
  return tostr("bogus objectid `", thing, "'");
else
  return tostr("`", thing[1], "' unexpected");
endif
