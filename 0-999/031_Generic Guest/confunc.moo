#31:confunc   this none this rxd

if (valid(cp = caller_perms()) && caller != this && !$perm_utils:controls(cp, this) && cp != this && caller != #0)
  return E_PERM;
else
  $guest_log:enter(1, time(), $string_utils:connection_hostname(this));
  ret = pass(@args);
  this:tell_lines(this:extra_confunc_msg());
  return ret;
endif
