#20:match_object   this none this rxd

":match_object(string,location[,someone])";
"Returns the object matching the given string for someone, on the assumption that s/he is in the given location.  `someone' defaults to player.";
"This first tries :literal_object(string), \"me\"=>someone,\"here\"=>location, then player:match(string) and finally location:match(string) if location is valid.";
"This is the default algorithm for use by room :match_object() and player :my_match_object() verbs.  Player verbs that are calling this directly should probably be calling :my_match_object instead.";
{string, here, ?who = player} = args;
if ($failed_match != (object = this:literal_object(string)))
  return object;
elseif (string == "me")
  return who;
elseif (string == "here")
  return here;
elseif (valid(pobject = who:match(string)) && string in {@pobject.aliases, pobject.name} || !valid(here))
  "...exact match in player or room is bogus...";
  return pobject;
elseif (valid(hobject = here:match(string)) && string in {@hobject.aliases, hobject.name} || pobject == $failed_match)
  "...exact match in room or match in player failed completely...";
  return hobject;
else
  return pobject;
endif
