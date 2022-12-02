#76:parse_verb_perms   this none this rxd

{oname, raw, data} = args;
if (typeof(raw) == STR)
  raw = {raw};
elseif (typeof(raw) == INT)
  return raw ? {oname, "rxd"} | {oname, 0};
endif
value = this:check_verb_perms(raw[1]);
if (typeof(value) == STR)
  return value;
endif
if (value[1] == "")
  value = "RD";
endif
return {oname, value[1] == "RD" ? 0 | value[1]};
