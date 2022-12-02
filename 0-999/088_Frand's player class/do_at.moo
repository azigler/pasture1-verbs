#88:do_at   this none this rxd

"'do_at (<location>)' - List the players at a given location.";
loc = args[1];
party = {};
for who in (this:at_players())
  if (who.location == loc)
    party = setadd(party, who);
  endif
endfor
this:print_at_items({loc}, {party});
