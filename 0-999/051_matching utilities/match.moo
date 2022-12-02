#51:match   this none this rxd

":match(string, object-list)";
"Return object in 'object-list' aliased to 'string'.";
"Matches on a wide variety of syntax, including:";
" \"5th axe\" -- The fifth object matching \"axe\" in the object list.";
" \"where's sai\" -- The only object contained in 'where' matching \"sai\" (possible $ambiguous_match).";
" \"where's second staff\" -- The second object contained in 'where' matching \"staff\".";
" \"my third dagger\" -- The third object in your inventory matching \"dagger\".";
"Ordinal matches are determined according to the match's position in 'object-list' or, if a possessive (such as \"where\" above) is given, then the ordinal is the nth match in that object's inventory.";
"In the matching room (#3879@LambdaMOO), the 'object-list' consists of first the player's contents, then the room's, and finally all exits leading from the room.";
{string, olist} = args;
if (!string)
  return $nothing;
elseif (string == "me")
  return player;
elseif (string == "here")
  return player.location;
elseif (valid(object = $string_utils:literal_object(string)))
  return object;
elseif (valid(object = $string_utils:match(string, olist, "aliases")))
  return object;
elseif (parsed = this:parse_ordinal_reference(string))
  return this:match_nth(parsed[2], olist, parsed[1]);
elseif (parsed = this:parse_possessive_reference(string))
  {whostr, objstr} = parsed;
  if (valid(whose = this:match(whostr, olist)))
    return this:match(objstr, whose.contents);
  else
    return whose;
  endif
else
  return object;
endif
"Profane (#30788) - Sat Jan  3, 1998 - Changed so literals get returned ONLY if in the passed object list.";
"Profane (#30788) - Sat Jan  3, 1998 - OK, that broke lots of stuff, so changed it back.";
