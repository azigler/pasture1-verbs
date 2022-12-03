#100:say(old)   any any any rx

if ($object_utils:has_callable_verb(player.location, "say") != {#3})
  "Idiot-proofed it against porting wizards who change $room to something other than #3 (since :say would not be defined on $room.) Clueful wizards can change this.";
  return player.location:(verb)(@args);
endif
au = $ansi_utils;
argstr = au:terminate_normal(argstr);
action = {"say", "ask", "exclaim"}[1 + index("?!", argstr[length(argstr)])];
action = punct == "!" ? "exclaim" | (punct == "?" ? "ask" | "say");
player:tell(tostr("You ", action, ", \"", argstr, "\""));
player.location:announce(tostr(au:ansi_title(player), " ", action), "s, \"", argstr, "\"");
