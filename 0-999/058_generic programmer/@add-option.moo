#58:@add-option   any (at/to) any rd

"I never, ever remember how to add to option packages. So here we are.";
if (!player.programmer)
  return E_PERM;
endif
set_task_perms(player);
package = player:my_match_object(iobjstr);
if (package == $failed_match || isa(package, $generic_options) == 0)
  return player:tell("You need to specify an option package.");
elseif (dobjstr in package.names)
  return player:tell("That option already exists.");
elseif (!player.wizard && package.owner != player)
  return player:tell("You don't own that option package.");
else
  dobjstr = strsub(dobjstr, " ", "_");
  player:tell("What text is displayed when the option is DISABLED?");
  text = {$command_utils:read()};
  player:tell("What text is displayed when the option is ENABLED?");
  text = {@text, $command_utils:read()};
  package:add_name(dobjstr);
  add_property(package, tostr("show_", dobjstr), text, {player, "rc"});
  player:tell("Option added!");
endif
