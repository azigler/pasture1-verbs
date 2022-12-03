#3:match   this none this rxd

target = {@this:contents(), @this:exits()};
try
  return $string_utils:newmatch(args[1], target);
except e (ANY)
  #133:tell("error with verb " + verb + ": " + e[2]);
  return $string_utils:match(args[1], target, "name", target, "aliases");
endtry
"Last modified Sat Dec  3 14:52:03 2022 UTC by caranov (#133).";
