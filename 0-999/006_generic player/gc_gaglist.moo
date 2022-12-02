#6:gc_gaglist   this none this rxd

caller == this || $perm_utils:controls(caller_perms(), this) || raise(E_PERM);
if (g = this.gaglist)
  recycler = $recycler;
  for o in (g)
    if (!recycler:valid(o))
      g = setremove(g, o);
    endif
  endfor
  this.gaglist = g;
endif
