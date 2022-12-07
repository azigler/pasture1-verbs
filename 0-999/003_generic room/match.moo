#3:match   this none this rxd

target = {@this:contents(), @this:exits()};
try
  return $match_utils:match(args[1], target);
except e (ANY)
  #133:tell("error with verb " + verb + ": " + e[2]);
  return $string_utils:match(args[1], target, "name", target, "aliases");
endtry
"Last modified Wed Dec  7 13:51:26 2022 UTC by caranov (#133).";
