#10:interception   this none this rxd

caller == this || raise(E_PERM);
{who} = args;
return (loc = who in this.intercepted_players) ? this.intercepted_actions[loc] | 0;
