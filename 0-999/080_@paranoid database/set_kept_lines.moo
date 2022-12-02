#80:set_kept_lines   this none this rxd

maximum = this.max_lines;
who = args[1];
if ($perm_utils:controls(caller_perms(), who) && is_player(who))
  l = tostr(who, "lines");
  this:ensure_props_exist(who, l, l);
  kept = min(args[2], maximum);
  this.(l) = kept;
  return kept;
else
  return E_PERM;
endif
