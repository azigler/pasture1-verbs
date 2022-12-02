#76:parse_@prop_flags   this none this rxd

{oname, raw, data} = args;
if (typeof(raw) != STR)
  return "Must be a string composed of the characters `rwc'.";
endif
len = length(raw);
for x in [1..len]
  if (!(raw[x] in {"r", "w", "c"}))
    return "Must be a string composed of the characters `rwc'.";
  endif
endfor
return {oname, raw};
