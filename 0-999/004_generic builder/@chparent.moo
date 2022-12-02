#4:@chparent   any (at/to) any rd

set_task_perms(player);
if ($command_utils:object_match_failed(object = player:my_match_object(dobjstr), dobjstr))
  "...bogus object...";
elseif ($command_utils:object_match_failed(parent = player:my_match_object(iobjstr), iobjstr))
  "...bogus new parent...";
elseif (this != player && !$object_utils:isa(player, $player))
  "...They chparented to #1 and want to chparent back to $prog.  Probably for some nefarious purpose...";
  player:notify("You don't seem to already be a valid player class.  Perhaps chparenting away from the $player hierarchy was not such a good idea.  Permission denied.");
elseif (is_player(object) && !$object_utils:isa(parent, $player))
  player:notify(tostr(object, " is a player and ", parent, " is not a player class."));
  player:notify("You really *don't* want to do this.  Trust me.");
else
  if ($object_utils:isa(object, $mail_recipient))
    if (!$command_utils:yes_or_no("Chparenting a mailing list is usually a really bad idea.  Do you really want to do it?  (If you don't know why we're asking this question, please say 'no'.)"))
      return player:tell("Aborted.");
    endif
  endif
  try
    result = player:_chparent(object, parent);
    player:notify("Parent changed.");
  except (E_INVARG)
    if (valid(object) && valid(parent))
      player:notify(tostr("Some property existing on ", parent, " is defined on ", object, " or one of its descendants."));
      player:notify(tostr("Try @check-chparent ", dobjstr, " to ", iobjstr));
    else
      player:notify("Either that is not a valid object or not a valid parent");
    endif
  except (E_PERM)
    player:notify("Either you don't own the object, don't own the parent, or the parent is not fertile.");
  except (E_RECMOVE)
    player:notify("That parent object is a descendant of the object!");
  endtry
endif
