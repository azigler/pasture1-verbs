#58:"@remove-option @rmoption @rm-option"   any (out of/from inside/from) any rd

if (!player.programmer)
  return E_PERM;
endif
set_task_perms(player);
package = player:my_match_object(iobjstr);
dobjstr = strsub(dobjstr, " ", "_");
if (package == $failed_match || isa(package, $generic_options) == 0)
  return player:tell("You need to specify an option package.");
elseif (dobjstr in package.names == 0)
  return player:tell("'", dobjstr, " isn't an option on ", $su:nn(package), ".");
elseif (!player.wizard && package.owner != player)
  return player:tell("You don't own that option package.");
else
  if ($cu:yes_or_no(tostr("Really delete option '", dobjstr, " from ", $su:nn(package), "?")) == 1)
    package:remove_name(dobjstr);
    delete_property(package, tostr("show_", dobjstr));
    player:tell("Option removed.");
  else
    player:tell("Aborted.");
  endif
endif
