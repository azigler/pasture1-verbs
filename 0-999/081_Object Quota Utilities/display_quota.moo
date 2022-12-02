#81:display_quota   this none this rxd

who = args[1];
if (caller_perms() == who)
  q = who.ownership_quota;
  total = typeof(who.owned_objects) == LIST ? length(setremove(who.owned_objects, who)) | 0;
  if (q == 0)
    player:tell(tostr("You can't create any more objects", total < 1 ? "." | tostr(" until you recycle some of the ", total, " you already own.")));
  else
    player:tell(tostr("You can create ", q, " new object", q == 1 ? "" | "s", total == 0 ? "." | tostr(" without recycling any of the ", total, " that you already own.")));
  endif
else
  if ($perm_utils:controls(caller_perms(), who))
    player:tell(tostr(who.name, "'s quota is currently ", who.ownership_quota, "."));
  else
    player:tell("Permission denied.");
  endif
endif
