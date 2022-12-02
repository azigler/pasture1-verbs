#24:do_register   this none this rxd

"do_register(name, email_address [,comments])";
"change player's email address.";
if (!caller_perms().wizard)
  return E_PERM;
endif
{whostr, email, @comments} = args;
comments = $string_utils:from_list(comments);
who = $string_utils:match_player(whostr);
if ($command_utils:player_match_failed(who, whostr))
  return;
endif
if (whostr != who.name && !(whostr in who.aliases) && whostr != tostr(who))
  player:notify(tostr("Must be a full name or an object number:  ", who.name, "(", who, ")"));
  return;
endif
if (reason = $network:invalid_email_address(email))
  player:notify(reason);
  if (!$command_utils:yes_or_no("Register anyway?"))
    return player:notify("re-registration aborted.");
  endif
endif
if (comments)
  $registration_db:add(who, email, comments);
else
  $registration_db:add(who, email);
endif
old = $wiz_utils:get_email_address(who);
$wiz_utils:set_email_address(who, email);
player:notify(tostr(who.name, " (", who, ") formerly ", old ? old | "unregistered", ", registered at ", email, ".", comments ? " [" + comments + "]" | ""));
