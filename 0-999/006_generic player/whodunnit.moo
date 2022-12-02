#6:whodunnit   this none this rxd

{record, trust, mistrust} = args;
s = {this, "???", this};
for w in (record)
  if (!valid(s[3]) || s[3].wizard || s[3] in trust && !(s[3] in mistrust) || s[1] == this)
    s = w;
  else
    return s;
  endif
endfor
return s;
