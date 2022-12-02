#37:_every_key   this none this rxd

if (caller != this)
  raise(E_PERM);
endif
info = this.(" " + args[1]);
prefix = args[1] + info[1];
r = info[3];
for i in [1..length(branches = info[2])]
  for new in (this:_every_key(prefix + branches[i]))
    r = setadd(r, new);
    $command_utils:suspend_if_needed(0);
  endfor
  $command_utils:suspend_if_needed(0);
endfor
return r;
