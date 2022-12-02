#155:get_email_address   this none this rxd

":get_email_address(OBJ <player>)";
"Attempt to get the player's e-mail address. This verb is MOO-dependent, but should work with LambdaCore if no other modifications are made.";
"If no e-mail could be found, return $failed_match.";
{who} = args;
if ($object_utils:has_callable_verb(who, "email_address") && (address = who:email_address()) != "")
  return address;
elseif ((info = `$accounts:info(who.account) ! ANY => {}') != {} && `index(info[4], "@") ! ANY')
  return info[4];
else
  return $failed_match;
endif
