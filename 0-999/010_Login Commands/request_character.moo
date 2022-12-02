#10:request_character   this none this rxd

"request_character(player, name, address)";
"return true if succeeded";
if (!caller_perms().wizard)
  return E_PERM;
endif
{who, name, address} = args;
connection = $string_utils:connection_hostname(who);
if (reason = $wiz_utils:check_player_request(name, address, connection))
  prefix = "";
  if (reason[1] == "-")
    reason = reason[2..$];
    prefix = "Please";
  else
    prefix = "Please try again, or, to register another way,";
  endif
  notify(who, reason);
  msg = tostr(prefix, " send mail to ", $login.registration_address, ", with the character name you want.");
  for l in ($generic_editor:fill_string(msg, 70))
    notify(who, l);
  endfor
  return 0;
endif
if (lines = $no_one:eval_d("$local.help.(\"multiple-characters\")")[2])
  notify(who, "Remember, in general, only one character per person is allowed.");
  notify(who, tostr("Do you already have a ", $network.moo_name, " character? [enter `yes' or `no']"));
  answer = read(who);
  if (answer == "yes")
    notify(who, "Process terminated *without* creating a character.");
    return 0;
  elseif (answer != "no")
    return notify(who, tostr("Please try again; when you get this question, answer `yes' or `no'. You answered `", answer, "'"));
  endif
  notify(who, "For future reference, do you want to see the full policy (from `help multiple-characters'?");
  notify(who, "[enter `yes' or `no']");
  if (read(who) == "yes")
    for x in (lines)
      for y in ($generic_editor:fill_string(x, 70))
        notify(who, y);
      endfor
    endfor
  endif
endif
notify(who, tostr("A character named `", name, "' will be created."));
notify(who, tostr("A random password will be generated, and e-mailed along with"));
notify(who, tostr(" an explanatory message to: ", address));
notify(who, tostr(" [Please double-check your email address and answer `no' if it is incorrect.]"));
notify(who, "Is this OK? [enter `yes' or `no']");
if (read(who) != "yes")
  notify(who, "Process terminated *without* creating a character.");
  return 0;
endif
if (!$network.active)
  $mail_agent:send_message(this.owner, $registration_db.registrar, "Player request", {"Player request from " + connection, ":", "", "@make-player " + name + " " + address});
  notify(who, tostr("Request for new character ", name, " email address '", address, "' accepted."));
  notify(who, tostr("Please be patient until the registrar gets around to it."));
  notify(who, tostr("If you don't get email within a week, please send regular"));
  notify(who, tostr("  email to: ", $login.registration_address, "."));
elseif ($player_db.frozen)
  notify(who, "Sorry, can't create any new players right now.  Try again in a few minutes.");
else
  new = $wiz_utils:make_player(name, address);
  password = new[2];
  new = new[1];
  notify(who, tostr("Character ", name, " (", new, ") created."));
  notify(who, tostr("Mailing password to ", address, "; you should get the mail very soon."));
  notify(who, tostr("If you do not get it, please do NOT request another character."));
  notify(who, tostr("Instead, send regular email to ", $login.registration_address, ","));
  notify(who, tostr("with the name of the character you requested."));
  $mail_agent:send_message(this.owner, $new_player_log, tostr(name, " (", new, ")"), {address, tostr(" Automatically created at request of ", valid(player) ? player.name | "unconnected player", " from ", connection, ".")});
  $wiz_utils:send_new_player_mail(tostr("Someone connected from ", connection, " at ", ctime(), " requested a character on ", $network.moo_name, " for email address ", address, "."), name, address, new, password);
  return 1;
endif
