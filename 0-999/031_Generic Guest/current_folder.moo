#31:current_folder   this none this rxd

if (caller_perms() in {this, this.owner})
  return pass(@args);
else
  return E_PERM;
endif
