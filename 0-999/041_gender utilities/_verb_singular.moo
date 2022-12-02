#41:_verb_singular   this none this rxd

{st, ?idx = 1} = args;
if (typeof(st) != STR)
  return E_INVARG;
endif
len = length(st);
if (len >= 3 && rindex(st, "n't") == len - 2)
  return this:_verb_singular(st[1..len - 3], idx) + "n't";
elseif (i = st in {"have", "are"})
  return this.({"have", "be"}[i])[idx];
elseif (st[len] == "y" && !index("aeiou", st[len - 1]))
  return st[1..len - 1] + "ies";
elseif (index("sz", st[len]) && index("aeiou", st[len - 1]))
  return st + st[len] + "es";
elseif (index("osx", st[len]) || (len > 1 && index("chsh", st[len - 1..len]) % 2))
  return st + "es";
else
  return st + "s";
endif
