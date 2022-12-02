#6:"@eject @eject! @eject!!"   any (out of/from inside/from) any rd

set_task_perms(player);
if (iobjstr == "here")
  iobj = player.location;
elseif (iobjstr == "me")
  iobj = player;
elseif ($command_utils:object_match_failed(iobj, iobjstr))
  return;
endif
if (!$perm_utils:controls(player, iobj))
  player:notify(tostr("You are not the owner of ", iobj.name, "."));
  return;
endif
if (dobjstr == "me")
  dobj = player;
else
  dobj = $string_utils:literal_object(dobjstr);
  if (dobj == $failed_match)
    dobj = iobj:match(dobjstr);
  endif
  if ($command_utils:object_match_failed(dobj, dobjstr))
    return;
  endif
endif
if (dobj.location != iobj)
  player:notify(tostr(dobj.name, "(", dobj, ") is not in ", iobj.name, "(", iobj, ")."));
  return;
endif
if (dobj.wizard)
  player:notify(tostr("Sorry, you can't ", verb, " a wizard."));
  dobj:tell(player.name, " tried to ", verb, " you.");
  return;
endif
iobj:(verb == "@eject" ? "eject" | "eject_basic")(dobj);
player:notify($object_utils:has_callable_verb(iobj, "ejection_msg") ? iobj:ejection_msg() | $room:ejection_msg());
if (verb != "@eject!!")
  dobj:tell($object_utils:has_callable_verb(iobj, "victim_ejection_msg") ? iobj:victim_ejection_msg() | $room:victim_ejection_msg());
endif
iobj:announce_all_but({player, dobj}, $object_utils:has_callable_verb(iobj, "oejection_msg") ? iobj:oejection_msg() | $room:oejection_msg());
