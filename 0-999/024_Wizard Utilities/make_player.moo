#24:make_player   this none this rxd

"create a player named NAME with email address ADDRESS; return {object, password}.  Optional third arg is comment to be put in registration db.";
"assumes $wiz_utils:check_player_request() has been called and it passes.";
if (!caller_perms().wizard)
  return E_PERM;
endif
{name, address, @rest} = args;
new = $quota_utils:bi_create($player_class, $nothing);
new.name = name;
new.aliases = {name};
new.password = $login:encrypt_password(password = $wiz_utils:random_password(5));
new.last_password_time = time();
new.last_connect_time = $maxint;
"Last disconnect time is creation time, until they login.";
new.last_disconnect_time = time();
$quota_utils:initialize_quota(new);
if (!(error = $wiz_utils:set_player(new)))
  return player:tell("An error, ", error, " occurred while trying to make ", new, " a player. The database is probably inconsistent.");
endif
$wiz_utils:set_email_address(new, address);
$registration_db:add(new, address, @rest);
move(new, $player_start);
new.programmer = $player_class.programmer;
return {new, password};
