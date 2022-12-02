#106:next_id   this none this rxd

if (caller == this)
  return tostr("I", this.next_id = this.next_id + 1);
else
  raise(E_PERM);
endif
