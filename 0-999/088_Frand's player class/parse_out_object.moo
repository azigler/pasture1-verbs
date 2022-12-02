#88:parse_out_object   this none this rxd

"'parse_out_object (<string>)' -> {<name>, <object>}, or 0. Given a string, attempt to find an object at its beginning or its end. An object can be either an object number, or 'here'. If this succeeds, return a list of the object and the unmatched part of the string, called the name. If it fails, return 0.";
words = $string_utils:words(args[1]);
if (!length(words))
  return 0;
endif
word1 = words[1];
wordN = words[$];
if (length(word1) && word1[1] == "#")
  start = 2;
  finish = length(words);
  what = toobj(word1);
elseif (word1 == "here")
  start = 2;
  finish = length(words);
  what = this.location;
elseif (length(wordN) && wordN[1] == "#")
  start = 1;
  finish = length(words) - 1;
  what = toobj(wordN);
elseif (wordN == "here")
  start = 1;
  finish = length(words) - 1;
  what = this.location;
else
  return 0;
endif
"toobj() has the nasty property that invalid strings get turned into #0. Here we just pretend that all references to #0 are actually meant for #-1.";
if (what == #0)
  what = $nothing;
endif
name = $string_utils:from_list(words[start..finish], " ");
if (!name)
  name = valid(what) ? what.name | "Nowhere";
endif
return {name, what};
