#79:initialize_quota   this none this rxd

if (!caller_perms().wizard)
  return E_PERM;
else
  args[1].size_quota = this.default_quota;
  args[1].ownership_quota = this.large_negative_number;
endif
