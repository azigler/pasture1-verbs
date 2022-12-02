#81:adjust_quota_for_programmer   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
else
  victim = args[1];
  oldquota = victim.ownership_quota;
  if ($object_utils:has_property($local, "second_char_registry") && $local.second_char_registry:is_second_char(victim))
    "don't increment quota for 2nd chars when programmering";
    victim.ownership_quota = oldquota;
  else
    victim.ownership_quota = oldquota + ($wiz_utils.default_programmer_quota - $wiz_utils.default_player_quota);
  endif
endif
