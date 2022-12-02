#50:parse_insert   this none this rxd

"parse_ins(who,string)  interprets string as an insertion point, i.e., a position between lines and returns the number of the following line or 0 if bogus.";
if (!(fuckup = this:ok(who = args[1])))
  return fuckup;
endif
{who, string} = args;
if (length(string) == 0)
  return E_INVARG;
endif
last = length(this.texts[who]) + 1;
ins = this.inserting[who];
if (i = index("-+", string[1]))
  rest = string[2..$];
  return (n = toint(rest)) || rest == "0" ? {ins - n, ins + n}[i] | E_INVARG;
else
  if (!(j = index(string, "^") || index(string, "_")))
    offset = 0;
  else
    offset = j == 1 || toint(string[1..j - 1]);
    if (!offset)
      return E_INVARG;
    elseif (string[j] == "^")
      offset = -offset;
    endif
  endif
  rest = string[j + 1..$];
  if (i = rest in {".", "$"})
    return offset + {ins, last}[i];
  elseif (!(n = toint(rest)))
    return E_INVARG;
  else
    return offset + (j && string[j] == "^") + n;
  endif
endif
