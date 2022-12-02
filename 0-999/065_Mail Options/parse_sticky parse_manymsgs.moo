#65:"parse_sticky parse_manymsgs"   this none this rxd

{oname, raw, data} = args;
if (typeof(raw) == LIST)
  if (length(raw) > 1)
    return "Too many arguments.";
  endif
  raw = raw[1];
elseif (typeof(raw) == INT)
  return {oname, raw && (oname == "manymsgs" ? 20 | 1)};
endif
if ((value = $code_utils:toint(raw)) == E_TYPE)
  return tostr("`", raw, "'?  Number expected.");
endif
return {oname, value};
