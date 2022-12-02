#1:"eject eject_nice eject_basic"   this none this rxd

"eject(victim) --- usable by the owner of this to remove victim from this.contents.  victim goes to its home if different from here, or $nothing or $player_start according as victim is a player.";
"eject_basic(victim) --- victim goes to $nothing or $player_start according as victim is a player; victim:moveto is not called.";
what = args[1];
nice = verb != "eject_basic";
perms = caller_perms();
if (!perms.wizard && perms != this.owner)
  raise(E_PERM);
elseif (!(what in this.contents) || what.wizard)
  return 0;
endif
if (nice && $object_utils:has_property(what, "home") && typeof(where = what.home) == OBJ && where != this && (is_player(what) ? `where:accept_for_abode(what) ! ANY' | `where:acceptable(what) ! ANY'))
else
  where = is_player(what) ? $player_start | $nothing;
endif
fork (0)
  if (what.location == this)
    "It didn't move when we asked it to, or :moveto is broken. Force it.";
    move(what, where);
  endif
endfork
return nice ? `what:moveto(where) ! ANY' | `move(what, where) ! ANY';
