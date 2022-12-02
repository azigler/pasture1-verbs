#6:"@listgag @gaglist @gagged"   any none none rxd

set_task_perms(valid(caller_perms()) ? caller_perms() | player);
if (!this.gaglist)
  player:notify(tostr("You are ", callers() ? "no longer gagging anything." | "not gagging anything right now."));
else
  player:notify(tostr("You are ", callers() ? "now" | "currently", " gagging ", $string_utils:nn(this.gaglist), "."));
endif
gl = {};
if (args)
  player:notify("Searching for players who may be gagging you...");
  for p in (players())
    if (typeof(`p.gaglist ! E_PERM') == LIST && this in p.gaglist)
      gl = {@gl, p};
    endif
    $command_utils:suspend_if_needed(10, "...searching gaglist...");
  endfor
  if (gl || !callers())
    player:notify(tostr($string_utils:nn(gl, " ", "No one"), " appear", length(gl) <= 1 ? "s" | "", " to be gagging you."));
  endif
endif
