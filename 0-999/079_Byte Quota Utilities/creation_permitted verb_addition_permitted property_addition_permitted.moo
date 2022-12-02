#79:"creation_permitted verb_addition_permitted property_addition_permitted"   this none this rxd

"Here's the tricky one.  Collect all the user's characters' cached usage data and total quotas.  Compare same.  If usage bigger than quotas, return 0.  Else, add up the total number of objects that haven't been measured recently.  If greater than the allowed, return 0.  Else, reluctantly, return 1.";
who = args[1];
if (who.wizard || who == $hacker)
  "... sorry folks --Rog";
  return 1;
endif
if (!$object_utils:has_property(who, "size_quota") || is_clear_property(who, "size_quota"))
  return 0;
endif
$recycler:check_quota_scam(who);
allwho = this:all_characters(who);
quota = 0;
usage = 0;
unmeasured = 0;
for x in (allwho)
  quota = quota + x.size_quota[1];
  usage = usage + x.size_quota[2];
  unmeasured = unmeasured + x.size_quota[4];
endfor
if (usage >= quota)
  return 0;
elseif (unmeasured >= this.max_unmeasured)
  return 0;
else
  return 1;
endif
