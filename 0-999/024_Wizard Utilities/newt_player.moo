#24:newt_player   this none this rxd

":newt_player(who [ , commentary] [, temporary])";
{who, ?comment = "", ?temporary = 0} = args;
if (!caller_perms().wizard)
  $error:raise(E_PERM);
elseif (length(args) < 1)
  $error:raise(E_ARGS);
elseif (typeof(who = args[1]) != OBJ || !is_player(who))
  $error:raise(E_INVARG);
else
  if (!comment)
    player:notify("So why has this player been newted?");
    comment = $command_utils:read();
  endif
  if (temporary)
    comment = temporary + comment;
  endif
  $login.newted = setadd($login.newted, who);
  if (msg = player:newt_victim_msg())
    notify(who, msg);
  endif
  notify(who, $login:newt_registration_string());
  boot_player(who);
  player:notify(tostr(who.name, " (", who, ") has been turned into a newt."));
  $mail_agent:send_message(player, $newt_log, tostr("@newt ", who.name, " (", who, ")"), {$string_utils:from_list(who.all_connect_places, " "), @comment ? {comment} | {}});
  if ($object_utils:isa(who.location, $room) && (msg = player:newt_msg()))
    who.location:announce_all_but({who}, msg);
  endif
  player:notify(tostr("Mail sent to ", $mail_agent:name($newt_log), "."));
endif
