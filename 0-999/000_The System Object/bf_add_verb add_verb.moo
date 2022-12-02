#0:"bf_add_verb add_verb"   this none this rxd

"add_verb() -- see help on the builtin for more information. This verb is called by the server when $server_options.protect_add_verb exists and is true and caller_perms() are not wizardly.";
who = caller_perms();
what = args[1];
info = args[2];
if (typeof(what) != OBJ)
  retval = E_TYPE;
elseif (!valid(what))
  retval = E_INVARG;
elseif (!$perm_utils:controls(who, what) && !what.w)
  "caller_perms() is not allowed to hack on the object in question";
  retval = E_PERM;
elseif (!$perm_utils:controls(who, info[1]))
  "caller_perms() is not permitted to add a verb with the specified owner.";
  retval = E_PERM;
elseif (index(info[2], "w") && !$server_options.permit_writable_verbs)
  retval = E_INVARG;
elseif (!$quota_utils:verb_addition_permitted(who))
  retval = E_QUOTA;
elseif (what.owner != who && !who.wizard && !$quota_utils:verb_addition_permitted(what.owner))
  retval = E_QUOTA;
elseif (!who.programmer)
  retval = E_PERM;
else
  "we now know that the caller's perms control the object or the object is writable, and we know that the caller's perms control the prospective verb owner (by more traditional means)";
  retval = `add_verb(@args) ! ANY';
endif
return typeof(retval) == ERR && $code_utils:dflag_on() ? raise(retval) | retval;
