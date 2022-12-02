#24:do_make_player   any any any rxd

"do_maker_player(name,email,[comment])";
"Common code for @make-player";
"If no password is given, generates a random password for the player.";
"Email-address is stored in $registration_db and on the player object.";
if (!caller_perms().wizard)
  return E_PERM;
endif
{name, email, @comments} = args;
comments = $string_utils:from_list(comments, " ");
reason = $wiz_utils:check_player_request(name, email);
if (others = $registration_db:find_exact(email))
  player:notify(email + " is the registered address of the following characters:");
  for x in (others)
    player:notify(tostr(valid(x[1]) ? x[1].name | "<recycled>", valid(x[1]) && !is_player(x[1]) ? " {nonplayer}" | "", " (", x[1], ") ", length(x) > 1 ? "[" + tostr(@x[2..$]) + "]" | ""));
  endfor
  if (!reason)
    reason = "Already registered.";
  endif
endif
if (reason)
  player:notify(reason);
  if (!$command_utils:yes_or_no("Create character anyway? "))
    player:notify("Character not created.");
    return;
  endif
endif
new = $wiz_utils:make_player(name, email, comments);
player:notify(tostr(name, " (", new[1], ") created with password `", new[2], "' for ", email, comments ? " [" + comments + "]" | ""));
$mail_agent:send_message(player, $new_player_log, tostr(name, " (", new[1], ")"), tostr(email, comments ? " " + comments | ""));
if ($network.active)
  if ($command_utils:yes_or_no("Send email to " + email + " with password? "))
    player:notify(tostr("Sending the password to ", email, "."));
    if ((result = $wiz_utils:send_new_player_mail(tostr("From ", player.name, "@", $network.moo_name, ":"), name, email, new[1], new[2])) == 0)
      player:notify(tostr("Mail sent successfully to ", email, "."));
    else
      player:tell("Cannot send mail: ", result);
    endif
  else
    player:notify("No mail sent.");
  endif
else
  player:notify("Sorry, the network isn't active.");
endif
