#22:prepositions   this none this rxd

text = args[1];
for p in ($code_utils:prepositions())
  text = {@text, tostr($string_utils:space(4), p)};
endfor
return text;
