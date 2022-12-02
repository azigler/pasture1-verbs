#20:match_player   this none this rxd

"match_player(name,name,...)      => {obj,obj,...}";
"match_player(name[,meobj])       => obj";
"match_player({name,...}[,meobj]) => {obj,...}";
"objs returned are either players, $failed_match, $ambiguous_match, or $nothing in the case of an empty string.";
"meobj (what to return for instances of `me') defaults to player; if given and isn't actually a player, `me' => $failed_match";
retstr = 0;
me = player;
if (length(args) < 2 || typeof(me = args[2]) == OBJ)
  me = valid(me) && is_player(me) ? me | $failed_match;
  if (typeof(args[1]) == STR)
    strings = {args[1]};
    retstr = 1;
    "return a string, not a list";
  else
    strings = args[1];
  endif
else
  strings = args;
  me = player;
endif
found = {};
for astr in (strings)
  if (!astr)
    aobj = $nothing;
  elseif (astr == "me")
    aobj = me;
  elseif (valid(aobj = $string_utils:literal_object(astr)) && is_player(aobj))
    "astr is a valid literal object number of some player, so we are done.";
  else
    aobj = $player_db:find(astr);
  endif
  found = {@found, aobj};
endfor
return retstr ? found[1] | found;
