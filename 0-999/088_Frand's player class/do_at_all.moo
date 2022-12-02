#88:do_at_all   this none this rxd

"'do_at_all ()' - List where everyone is, sorted by popularity of location. This is called when you type '@at'.";
locations = {};
parties = {};
counts = {};
for who in (this:at_players())
  loc = who.location;
  if (i = loc in locations)
    parties[i] = setadd(parties[i], who);
    counts[i] = counts[i] - 1;
  else
    locations = {@locations, loc};
    parties = {@parties, {who}};
    counts = {@counts, 0};
  endif
endfor
locations = $list_utils:sort(locations, counts);
parties = $list_utils:sort(parties, counts);
this:print_at_items(locations, parties);
