#20:char_list   this none this rxd

":char_list(string) => string as a list of characters.";
"   e.g., :char_list(\"abad\") => {\"a\",\"b\",\"a\",\"d\"}";
if (30 < (len = length(string = args[1])))
  return {@this:char_list(string[1..$ / 2]), @this:char_list(string[$ / 2 + 1..$])};
else
  l = {};
  for c in [1..len]
    l = {@l, string[c]};
  endfor
  return l;
endif
