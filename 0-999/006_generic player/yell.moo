#6:yell   any any any rxd

if (!args)
  return player:tell("What would you like to yell?");
endif
what = tostr(@args);
if (isa(this.location, $room) == 0)
  return player:tell("You are unable to yell here.");
endif
player:tell("You yell, \"" + what + "\"");
for i in (this.location:get_nearby_rooms(3))
  i:announce_all(this.name + " yells, \"" + what + "\"");
endfor
return 1;
"Last modified Sat Dec  3 19:04:51 2022 UTC by caranov (#133).";
