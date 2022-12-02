#24:initialize_owned   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
else
  set_task_perms(caller_perms());
  player:tell("Beginning initialize_owned:  ", ctime());
  for o in [#0..max_object()]
    if (valid(o))
      if ($object_utils:isa(owner = o.owner, $player) && typeof(owner.owned_objects) == LIST)
        owner.owned_objects = setadd(owner.owned_objects, o);
      endif
    endif
    $command_utils:suspend_if_needed(0);
  endfor
  player:tell("Done adding, beginning verification pass.");
  this:verify_owned_objects();
  player:tell("Finished:  ", ctime());
endif
