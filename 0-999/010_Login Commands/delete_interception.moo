#10:delete_interception   this none this rxd

caller == this || raise(E_PERM);
{who} = args;
if (loc = who in this.intercepted_players)
  this.intercepted_players = listdelete(this.intercepted_players, loc);
  this.intercepted_actions = listdelete(this.intercepted_actions, loc);
  return 1;
else
  "raise an error?  nah.";
  return 0;
endif
