#24:verify_owned_objects   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
else
  for p in (players())
    if (typeof(p.owned_objects) == LIST)
      for o in (p.owned_objects)
        if (typeof(o) != OBJ || !valid(o) || o.owner != p)
          p.owned_objects = setremove(p.owned_objects, o);
          player:tell("Removed ", $string_utils:nn(o), " from ", $string_utils:nn(p), "'s .owned_objects list.");
          if (typeof(o) == OBJ && valid(o) && typeof(o.owner.owned_objects) == LIST)
            o.owner.owned_objects = setadd(o.owner.owned_objects, o);
          endif
        endif
        $command_utils:suspend_if_needed(0, p);
      endfor
    endif
  endfor
endif
