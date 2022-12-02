#58:"@disown @disinherit"   any any any rd

"Syntax: @disown <object> [from <object>]";
"This command is used to remove unwanted children of objects you control. If you control an object, and there is a child of that object you do not want, this command will chparent() the object to its grandparent.";
set_task_perms(player);
if (prepstr)
  if (prepstr != "from")
    player:notify("Usage:  ", verb, " <object> [from <object>]");
    return;
  elseif ($command_utils:object_match_failed(iobj = player:my_match_object(iobjstr), iobjstr))
    "... from WHAT?..";
    return;
  elseif (valid(dobj = $string_utils:literal_object(dobjstr)))
    "... literal object number...";
    if (parent(dobj) != iobj)
      player:notify(tostr(dobj, " is not a child of ", iobj.name, " (", iobj, ")"));
      return;
    endif
  elseif ($command_utils:object_match_failed(dobj = $string_utils:match(dobjstr, children(iobj), "name", children(iobj), "aliases"), dobjstr))
    "... can't match dobjstr against any children of iobj";
    return;
  endif
elseif ($command_utils:object_match_failed(dobj = player:my_match_object(dobjstr), dobjstr))
  "... can't match dobjstr...";
  return;
endif
try
  if ($object_utils:disown(dobj))
    player:notify(tostr(dobj.name, " (", dobj, ")'s parent is now ", (grandparent = parent(dobj)).name, " (", grandparent, ")."));
  else
    "this should never happen";
  endif
except e (E_PERM, E_INVARG)
  {code, message, value, traceback} = e;
  player:notify(message);
endtry
