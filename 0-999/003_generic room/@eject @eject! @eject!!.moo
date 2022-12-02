#3:"@eject @eject! @eject!!"   any none none rd

set_task_perms(player);
if ($command_utils:object_match_failed(dobj, dobjstr))
  return;
elseif (dobj.location != this)
  is = $gender_utils:get_conj("is", dobj);
  player:tell(dobj.name, "(", dobj, ") ", is, " not here.");
  return;
elseif (!$perm_utils:controls(player, this))
  player:tell("You are not the owner of this room.");
  return;
elseif (dobj.wizard)
  player:tell("Sorry, you can't ", verb, " a wizard.");
  dobj:tell(player.name, " tried to ", verb, " you.");
  return;
endif
iobj = this;
player:tell(this:ejection_msg());
this:(verb == "@eject" ? "eject" | "eject_basic")(dobj);
if (verb != "@eject!!")
  dobj:tell(this:victim_ejection_msg());
endif
this:announce_all_but({player, dobj}, this:oejection_msg());
