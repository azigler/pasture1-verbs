#88:check_refusal_actions   this none this rxd

"'check_refusal_actions (<actions>)' - Check a list of refusal actions, and return whether they are all legal.";
actions = args[1];
legal_actions = this:refusable_actions();
for action in (actions)
  if (!(action in legal_actions))
    return 0;
  endif
endfor
return 1;
