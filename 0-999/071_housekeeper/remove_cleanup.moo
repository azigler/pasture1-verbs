#71:remove_cleanup   any none none rxd

if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
endif
{what, ?who = player} = args;
if (i = what in this.clean)
  if (!this:controls(i, who))
    return tostr("You may remove an object from ", this.name, " list only if you own the object, the place it is kept, or if you placed the original cleaning order.");
  endif
  this.clean = listdelete(this.clean, i);
  this.destination = listdelete(this.destination, i);
  this.requestors = listdelete(this.requestors, i);
  return tostr(what.name, " (", what, ") removed from cleanup list.");
else
  return tostr(what.name, " not in cleanup list.");
endif
