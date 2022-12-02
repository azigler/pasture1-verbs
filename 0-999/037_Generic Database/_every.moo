#37:_every   this none this rxd

if (caller != this)
  raise(E_PERM);
endif
info = this.(" " + args[1]);
prefix = args[1] + info[1];
r = $list_utils:remove_duplicates(info[4]);
for i in [1..length(branches = info[2])]
  for new in (this:_every(prefix + branches[i]))
    r = setadd(r, new);
  endfor
endfor
return r;
