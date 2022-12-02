#71:add_cleanup   any any any rxd

if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
endif
{what, ?who = player, ?where = what.location} = args;
if (what < #1 || !valid(what))
  return "invalid object";
endif
if ($object_utils:isa(who, $guest))
  return tostr("Guests can't use the ", this.name, ".");
endif
if (!is_player(who))
  return tostr("Non-players can't use the ", this.name, ".");
endif
if (!valid(where))
  return tostr("The ", this.name, " doesn't know how to find ", where, " in order to put away ", what.name, ".");
endif
if (is_player(what))
  return "The " + this.name + " doesn't do players, except to cart them home when they fall asleep.";
endif
for x in (this.eschews)
  if ($object_utils:isa(what, x[1]))
    ok = 0;
    for y in [3..length(x)]
      if ($object_utils:isa(what, x[y]))
        ok = 1;
      endif
    endfor
    if (!ok)
      return tostr("The ", this.name, " doesn't do ", x[2], "!");
    endif
  endif
endfor
if ($object_utils:has_callable_verb(where, "litterp") ? where:litterp(what) | where in this.public_places && !(what in where.residents))
  return tostr("The ", this.name, " won't litter ", where.name, "!");
endif
if (i = what in this.clean)
  if (!this:controls(i, who) && valid(this.destination[i]))
    return tostr($recycler:valid(tr = this.requestors[i]) ? tr.name | "Someone", " already asked that ", what.name, " be kept at ", this.destination[i].name, "!");
  endif
  this.requestors[i] = who;
  this.destination[i] = where;
else
  this.clean = {what, @this.clean};
  this.requestors = {who, @this.requestors};
  this.destination = {where, @this.destination};
endif
return tostr("The ", this.name, " will keep ", what.name, " (", what, ") at ", valid(where) ? where.name + " (" + tostr(where) + ")" | where, ".");
