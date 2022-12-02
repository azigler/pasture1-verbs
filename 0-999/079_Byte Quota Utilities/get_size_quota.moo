#79:get_size_quota   this none this rxd

"Return args[1]'s quotas.  second arg of 1 means add all second chars.";
{who, ?all = 0} = args;
if (all && (caller == this || this:can_peek(caller_perms(), who)))
  all = this:all_characters(who);
else
  all = {who};
endif
baseline = {0, 0, 0, 0};
for x in (all)
  baseline[1] = baseline[1] + x.size_quota[1];
  baseline[2] = baseline[2] + x.size_quota[2];
  baseline[3] = min(baseline[3], x.size_quota[3]) || x.size_quota[3];
  baseline[4] = baseline[4] + x.size_quota[4];
endfor
return baseline;
