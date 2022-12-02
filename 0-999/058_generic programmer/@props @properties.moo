#58:"@props @properties"   any any any r

"Usage: @properties <object>";
"Alias: @props";
"Displays all properties defined on <object>. Properties unreadable by you display as `E_PERM'.";
if (player != this)
  return player:tell(E_PERM);
endif
set_task_perms(player);
ob = this:my_match_object(argstr);
if (!$command_utils:object_match_failed(ob, argstr))
  this:notify(tostr(";properties(", $code_utils:corify_object(ob), ") => ", toliteral($object_utils:accessible_props(ob))));
endif
"Last modified Mon Nov 28 06:21:21 2005 PST, by Roebare (#109000).";
