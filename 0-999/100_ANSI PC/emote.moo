#100:emote   any any any rx

if ($object_utils:has_callable_verb(player.location, "say") != {#3})
  "Idiot-proofed it against porting wizards who change $room to something other than #3 (since :say would not be defined on $room.) Clueful wizards can change this.";
  return player.location:(verb)(@args);
endif
if (argstr && argstr[1] == ":")
  argstr[1..1] = "";
else
  argstr[1..0] = " ";
endif
player.location:announce_all($ansi_utils:ansi_title(player), argstr);
