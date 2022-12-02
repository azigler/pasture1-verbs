#45:moveto   this none this rxd

if (this:is_writable_by(caller_perms()) || this:is_writable_by(caller))
  pass(@args);
else
  return E_PERM;
endif
