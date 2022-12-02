#81:initialize_quota   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
else
  args[1].ownership_quota = $wiz_utils.default_player_quota;
endif
