#99:get_code   this none this rx

if (caller != this)
  return E_PERM;
endif
{code, escape_char, ?truecolor_match = 0, ?xterm_256_match = 0} = args;
if (truecolor_match)
  ret = tostr(escape_char || this.escape, "[", code[1] == "b" ? "48" | "38");
  ret = substitute(tostr(ret, ";2;%4;%5;%6m"), truecolor_match);
  return ret;
elseif (xterm_256_match)
  ret = tostr(escape_char || this.escape, "[", code[1] == "b" ? "48" | "38");
  ret = tostr(ret, ";5;", code[code[1] == "b" ? 4 | 2..$], "m");
  return ret;
else
  return strsub(strsub(this.("code_" + code), "e", escape_char || this.escape, 1), "b", this.beep);
endif
