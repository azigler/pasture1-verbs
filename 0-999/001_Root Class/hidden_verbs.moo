#1:hidden_verbs   this none this rxd

"hidden_verbs(who)";
"returns a list of verbs on this that should be hidden from examine";
"the player who's examining is passed in, so objects can hide verbs from specific players";
"verbs are returned as {location, full_verb_name, args} or just full_verb_name.  full_verb name is what shows up in verb_info(object, verb)[2], for example \"d*op th*row\".";
if (caller == this || $perm_utils:controls(caller_perms(), this))
  hidden = {};
  what = this;
  while (what != $nothing)
    for i in [1..length(verbs(what))]
      info = verb_info(what, i);
      if (!index(info[2], "r"))
        hidden = setadd(hidden, {what, info[3], verb_args(what, i)});
      endif
    endfor
    what = parent(what);
  endwhile
  return hidden;
else
  return E_PERM;
endif
