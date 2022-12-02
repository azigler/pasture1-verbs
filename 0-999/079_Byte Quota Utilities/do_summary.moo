#79:do_summary   any (with/using) this rxd

who = args[1];
results = this:summarize_one_user(who);
{total, nuncounted, nzeros, oldest, eldest} = results;
player:tell(who.name, " statistics:");
player:tell("  ", $string_utils:group_number(total), " bytes of storage measured.");
player:tell("  Oldest measurement date ", ctime(oldest), " (", $string_utils:from_seconds(time() - oldest), " ago) of object ", eldest, " (", valid(eldest) ? eldest.name | "$nothing", ")");
if (nzeros || nuncounted)
  player:tell("  Number of objects with no statistics recorded:  ");
  player:tell("      ", nzeros, " recently created, ", nuncounted, " not descendents of #1");
endif
