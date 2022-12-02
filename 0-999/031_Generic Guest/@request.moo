#31:@request   any any any rd

"Usage:  @request <player-name> for <email-address>";
if (player != this)
  return player:tell(E_PERM);
endif
if (this.request)
  return player:tell("Sorry, you appear to have already requested a character.");
endif
name = dobjstr;
if (prepstr != "for" || (!dobjstr || index(address = iobjstr, " ")))
  return player:notify_lines($code_utils:verb_usage());
endif
if ($login:request_character(player, name, address))
  this.request = 1;
endif
"Copied from Generic Guest (#5678):@request by Froxx (#49853) Mon Apr  4 10:49:26 1994 PDT";
