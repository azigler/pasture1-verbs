#10:_match_player   this none this rxd

":_match_player(name)";
"This is the matching routine used by @connect.";
"returns either a valid player corresponding to name or $failed_match.";
name = args[1];
if (valid(candidate = $string_utils:literal_object(name)) && is_player(candidate))
  return candidate;
endif
".....uncomment this to trust $player_db and have `connect' recognize aliases";
if (valid(candidate = $player_db:find_exact(name)) && is_player(candidate))
  return candidate;
endif
".....uncomment this if $player_db gets hosed and you want by-name login";
". for candidate in (players())";
".   if (candidate.name == name)";
".     return candidate; ";
".   endif ";
". endfor ";
".....";
return $failed_match;
