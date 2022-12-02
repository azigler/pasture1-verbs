#31:notify   this none this rxd

if (caller_perms().wizard || caller_perms() in {this, this.owner} || caller == this)
  return pass(@args);
else
  return E_PERM;
endif
