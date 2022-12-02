#3:say   any any any rx

try
  player:tell("You say, \"", argstr, "\"");
  this:announce(player.name, " ", $gender_utils:get_conj("says", player), ", \"", argstr, "\"");
except (ANY)
  "Don't really need to do anything but ignore the idiot who has a bad :tell";
endtry
