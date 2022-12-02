#63:_recreate   this none this rxd

"Return a toad (child of #1, owned by $hacker) from this.contents.  Move it to #-1.  Recreate as a child of args[1], or of #1 if no args are given.  Chown to caller_perms() or args[2] if present.";
{?what = #1, ?who = caller_perms()} = args;
if (!(caller_perms().wizard || who == caller_perms()))
  return E_PERM;
elseif (!(valid(what) && is_player(who)))
  return E_INVARG;
elseif (who != what.owner && !what.f && !who.wizard && !caller_perms().wizard)
  return E_PERM;
endif
potential = next_recycled_object();
if (typeof(potential) == OBJ)
  return this:setup_toad(potential, who, what);
else
  return E_NONE;
endif
