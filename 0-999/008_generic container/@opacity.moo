#8:@opacity   this is any rd

if (!$perm_utils:controls(player, this))
  player:tell("Can't set opacity of something you don't own.");
elseif (iobjstr != "0" && !toint(iobjstr))
  player:tell("Opacity must be an integer (0, 1, 2).");
else
  player:tell("Opacity changed:  Now " + {"transparent.", "opaque.", "a black hole."}[1 + this:set_opaque(toint(iobjstr))]);
endif
