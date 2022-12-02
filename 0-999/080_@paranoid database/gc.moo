#80:gc   this none this rxd

if (caller != this && caller_perms() != #-1 && caller_perms() != player || !player.wizard)
  $error:raise(E_PERM);
endif
threshold = 60 * 60 * 24 * 3;
for x in (properties(this))
  if (x[1] == "#")
    l = length(x);
    who = toobj(x[1..l - 5]);
    if (!valid(who) || !is_player(who) || !this:is_paranoid(who))
      delete_property(this, x);
    else
      if (index(x, "lines"))
        if (typeof(this.(x)) != INT)
          this.(x) = 10;
        endif
      elseif (index(x, "pdata"))
        if (!$object_utils:connected(who) && who.last_disconnect_time < time() - threshold && who.last_connect_time < time() - threshold)
          this.(x) = {};
        endif
        if (typeof(this.(x)) != LIST)
          this.(x) = {};
        endif
      endif
    endif
  endif
  $command_utils:suspend_if_needed(0);
endfor
