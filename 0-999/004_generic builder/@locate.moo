#4:@locate   any any any rxd

"Finds objects around the MOO.";
if (!args)
  return player:tell("Syntax: @locate <keyword>");
endif
what = tostr(@args);
player:tell("Locating all objects matching " + what + ":");
player:tell();
objects = locate_by_name(what);
if (!objects)
  return player:tell("There don't appear to be any objects which match to this keyword.");
endif
for i in (objects)
  player:tell($string_utils:nn(i) + ", owned by " + $string_utils:nn(i.owner) + ", currently located at " + $string_utils:nn(i.location));
endfor
player:tell();
player:tell(objects:length(), " objects found.");
"Last modified Sat Dec  3 17:24:43 2022 UTC by caranov (#133).";
