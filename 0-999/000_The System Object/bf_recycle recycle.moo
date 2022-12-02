#0:"bf_recycle recycle"   this none this rxd

"recycle(object) -- see help on the builtin. This verb is called by the server when $server_options.protect_recycle exists and is true and caller_perms() are not wizardly.";
{what} = args;
if (!valid(what))
  retval = E_INVARG;
elseif (!$perm_utils:controls(who = caller_perms(), what))
  retval = E_PERM;
elseif ((p = `is_player(what) ! E_TYPE => 0') && !who.wizard)
  for p in ($wiz_utils:connected_wizards_unadvertised())
    p:tell($string_utils:pronoun_sub("%N (%#) is currently trying to destroy %t (%[#t])", who, what));
  endfor
  retval = E_PERM;
else
  if (p)
    $wiz_utils:unset_player(what);
  endif
  $recycler:kill_all_tasks(what);
  retval = `recycle(what) ! ANY';
endif
return typeof(retval) == ERR && $code_utils:dflag_on() ? raise(retval) | retval;
