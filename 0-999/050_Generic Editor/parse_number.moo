#50:parse_number   this none this rxd

"parse_number(who,string,before)   interprets string as a line number.  In the event that string is `.', `before' tells us which line to use.  Return 0 if string is bogus.";
{who, string, before} = args;
if (!(fuckup = this:ok(who)))
  return fuckup;
endif
last = length(this.texts[who]);
ins = this.inserting[who] - 1;
after = !before;
if (!string)
  return 0;
elseif ("." == string)
  return ins + after;
elseif (!(i = index("_^$", string[slen = length(string)])))
  return toint(string);
else
  start = {ins + 1, ins, last + 1}[i];
  n = 1;
  if (slen > 1 && !(n = toint(string[1..slen - 1])))
    return 0;
  elseif (i % 2)
    return start - n;
  else
    return start + n;
  endif
endif
