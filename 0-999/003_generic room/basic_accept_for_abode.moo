#3:basic_accept_for_abode   this none this rxd

who = args[1];
return valid(who) && (this.free_home || $perm_utils:controls(who, this) || (typeof(residents = this.residents) == LIST ? who in this.residents | who == this.residents));
