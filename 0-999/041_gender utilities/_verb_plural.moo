#41:_verb_plural   this none this rxd

{st, idx} = args;
if (typeof(st) != STR)
  return E_INVARG;
endif
len = length(st);
if (len >= 3 && rindex(st, "n't") == len - 2)
  return this:_verb_plural(st[1..len - 3], idx) + "n't";
elseif (i = st in {"has", "is"})
  return this.({"have", "be"}[i])[idx];
elseif (st == "was")
  return idx > 6 ? "were" | st;
elseif (len <= 3 || st[len] != "s")
  return st;
elseif (st[len - 1] != "e")
  return st[1..len - 1];
  "elseif ((r = (rindex(st, \"sses\") || rindex(st, \"zzes\"))) && (r == (len - 3)))";
elseif ((r = rindex(st, "zzes")) && r == len - 3)
  return st[1..len - 3];
elseif (st[len - 2] == "h" && index("cs", st[len - 3]) || index("ox", st[len - 2]) || st[len - 3..len - 2] == "ss")
  return st[1..len - 2];
  "washes => wash, belches => belch, boxes => box";
  "used to have || ((st[len - 2] == \"s\") && (!index(\"aeiouy\", st[len - 3])))";
  "so that <consonant>ses => <consonant>s";
  "known examples: none";
  "counterexample: browses => browse";
  "update of sorts--put in code to handle passes => pass";
elseif (st[len - 2] == "i")
  return st[1..len - 3] + "y";
else
  return st[1..len - 1];
endif
