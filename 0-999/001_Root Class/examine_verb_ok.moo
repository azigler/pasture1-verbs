#1:examine_verb_ok   this none this rxd

"examine_verb_ok(loc, index, info, syntax, commands_ok, hidden_verbs)";
"loc is the object that defines the verb; index is which verb on the object; info is verb_info; syntax is verb_args; commands_ok is determined by this:commands_ok, probably, but passed in so we don't have to calculate it for each verb.";
"hidden_verbs is passed in for the same reasons.  It should be a list, each of whose entries is either a string with the full verb name to be hidden (e.g., \"d*rop th*row\") or a list of the form {verb location, full verb name, args}.";
if (caller == this || $perm_utils:controls(caller_perms(), this))
  {loc, index, info, syntax, commands_ok, hidden_verbs} = args;
  vname = info[3];
  return syntax[2..3] != {"none", "this"} && !index(vname, "(") && (commands_ok || "this" in syntax) && `verb_code(loc, index) ! ANY' && !(vname in hidden_verbs) && !({loc, vname, syntax} in hidden_verbs);
else
  return E_PERM;
endif
