#3:emote   any any any rxd

if (argstr != "" && argstr[1] == ":")
  this:announce_all(player.name, argstr[2..length(argstr)]);
else
  this:announce_all(player.name, " ", argstr);
endif
