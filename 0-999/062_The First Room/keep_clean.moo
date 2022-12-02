#62:keep_clean   this none this rxd

"Copied from The Coat Closet (#11):keep_clean by Haakon (#2) Mon May  8 10:47:08 1995 PDT";
if ($perm_utils:controls(caller_perms(), this))
  junk = {};
  while (1)
    for x in (junk)
      $command_utils:suspend_if_needed(0);
      if (x in this.contents)
        "This is old junk that's still around five minutes later.  Clean it up.";
        if (!valid(x.owner))
          move(x, $nothing);
          #2:tell(">**> Cleaned up orphan object `", x.name, "' (", x, "), owned by ", x.owner, ", to #-1.");
        elseif (!$object_utils:contains(x, x.owner))
          move(x, x.owner);
          x.owner:tell("You shouldn't leave junk in ", this.name, "; ", x.name, " (", x, ") has been moved to your inventory.");
          #2:tell(">**> Cleaned up `", x.name, "' (", x, "), owned by `", x.owner.name, "' (", x.owner, "), to ", x.owner, ".");
        endif
      endif
    endfor
    junk = {};
    for x in (this.contents)
      if (seconds_left() < 2 || ticks_left() < 1000)
        suspend(0);
      endif
      if (!is_player(x))
        junk = {@junk, x};
      endif
    endfor
    suspend(5 * 60);
  endwhile
endif
