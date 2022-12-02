#10:add_interception   this none this rxd

caller == this || raise(E_PERM);
{who, verbname, @arguments} = args;
who in this.intercepted_players && raise(E_INVARG, "Player already has an interception set.");
this.intercepted_players = {@this.intercepted_players, who};
this.intercepted_actions = {@this.intercepted_actions, {verbname, @arguments}};
return 1;
