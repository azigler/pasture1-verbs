#0:"bf_set_verb_info set_verb_info"   this none this rxd

"set_verb_info() -- see help on the builtin for more information. This verb is called by the server when $server_options.protect_set_verb_info exists and is true and caller_perms() are not wizardly.";
{o, v, i} = args;
if (typeof(vi = `verb_info(o, v) ! ANY') == ERR)
  "probably verb doesn't exist";
  retval = vi;
elseif (!$perm_utils:controls(cp = caller_perms(), vi[1]))
  "perms don't control the current verb owner";
  retval = E_PERM;
elseif (typeof(i) != LIST || typeof(no = i[1]) != OBJ)
  "info is malformed";
  retval = E_TYPE;
elseif (!valid(no) || !is_player(no))
  "invalid new verb owner";
  retval = E_INVARG;
elseif (!$perm_utils:controls(cp, no))
  "perms don't control prospective verb owner";
  retval = E_PERM;
elseif (index(i[2], "w") && !`$server_options.permit_writable_verbs ! E_PROPNF, E_INVIND => 1')
  retval = E_INVARG;
else
  retval = `set_verb_info(o, v, i) ! ANY';
endif
return typeof(retval) == ERR && $code_utils:dflag_on() ? raise(retval) | retval;
