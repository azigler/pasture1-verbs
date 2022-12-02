#72:return_address_for   this none this rxd

":return_address_for(player) => string of 'return address'. Currently inbound mail doesn't work, so this is a bogus address.";
who = args[1];
if (valid(who) && is_player(who))
  return tostr(toint(who), "@", this.site, " (", who.name, ")");
else
  return tostr($login.registration_address, " (non-player ", who, ")");
endif
