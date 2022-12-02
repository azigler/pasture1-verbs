#79:display_quota   this none this rxd

who = args[1];
if (this:can_peek(caller_perms(), who) && length(all = this:all_characters(who)) > 1)
  many = 1;
else
  many = 0;
  all = {who};
endif
if (many)
  tquota = 0;
  tusage = 0;
  ttime = $maxint;
  tunmeasured = 0;
  tunmeasurable = 0;
endif
for x in (all)
  {quota, usage, timestamp, unmeasured} = x.size_quota;
  unmeasurable = 0;
  if (unmeasured >= 100)
    unmeasurable = unmeasured / 100;
    unmeasured = unmeasured % 100;
  endif
  if (many)
    player:tell(x.name, " quota: ", $string_utils:group_number(quota), "; usage: ", $string_utils:group_number(usage), "; unmeasured: ", unmeasured, "; no .object_size: ", unmeasurable, ".");
    tquota = tquota + quota;
    tusage = tusage + usage;
    ttime = min(ttime, timestamp);
    tunmeasured = tunmeasured + unmeasured;
    tunmeasurable = tunmeasurable + unmeasurable;
  endif
endfor
if (many)
  this:display_quota_summary(who, tquota, tusage, ttime, tunmeasured, tunmeasurable);
else
  this:display_quota_summary(who, quota, usage, timestamp, unmeasured, unmeasurable);
endif
