#1:match   this none this rxd

c = this:contents();
try
  return $match_utils:match(args[1], c);
except e (ANY)
  #133:tell("error with " + verb + ".");
  return $string_utils:match(args[1], c, "name", c, "aliases");
endtry
"Last modified Wed Dec  7 13:50:03 2022 UTC by caranov (#133).";
