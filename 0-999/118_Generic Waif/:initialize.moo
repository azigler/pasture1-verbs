#118::initialize   this none this rxd

"the perms check you want is probably:";
if (caller == this || caller == this.class)
  "allows pass() and :new()";
else
  raise(E_PERM);
endif
