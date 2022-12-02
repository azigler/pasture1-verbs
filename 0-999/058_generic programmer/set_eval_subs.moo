#58:set_eval_subs   none none none rxd

"Copied from Player Class hacked with eval that does substitutions and assorted stuff (#8855):set_eval_subs by Geust (#24442) Fri Aug  5 13:18:59 1994 PDT";
if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
elseif (typeof(subs = args[1]) != LIST)
  return E_TYPE;
else
  for pair in (subs)
    if (length(pair) != 2 || typeof(pair[1] != STR) || typeof(pair[2] != STR))
      return E_INVARG;
    endif
  endfor
endif
return `this.eval_subs = subs ! ANY';
