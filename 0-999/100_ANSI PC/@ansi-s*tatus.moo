#100:@ansi-s*tatus   any any any rd

"Usage:";
"  @ansi-status                   - Displays various information about the";
"                                   status of the ANSI system.";
"  @ansi-status version           - Only displays the version number.";
"  @ansi-status message           - Only displays the ANSI message.";
"Trusted users only:";
"  @ansi-status activate          - Activates the ANSI system.";
"  @ansi-status deactivate        - Deactivates the ANSI system.";
"  @ansi-status message <message> - Sets the ANSI message to <message>.";
"  @ansi-status input             - Same as 'message' but lets you input";
"                                   more than one line.";
"  @ansi-status clear             - Clears the ANSI message.";
"  @ansi-status diagnostic        - Runs the ANSI self-diagnostic and";
"                                   reports the results.";
"  @ansi-status diagnostic fix    - Same as above but fixes anything it can.";
"  @ansi-status update            - Updates all the caches, this should be";
"                                   run every once in a while.  See";
"                                   'help $ansi_utils:update_all' for more info.";
au = $ansi_utils;
if (args)
  subcommand = args[1];
  args[1..1] = {};
else
  subcommand = "";
endif
trusts = au:trusts(player);
show = 0;
if (player != this)
  player:tell(E_PERM);
elseif (!subcommand)
  player:notify_lines($ansi_utils:ansi_status());
  trusts && player:notify("You are trusted by the ANSI system.");
  show = 1;
elseif (subcommand == "help")
  player:notify_lines($code_utils:verb_documentation());
elseif (subcommand == "version")
  player:notify(tostr("Currently running ANSI Version ", au.version, "."));
elseif (subcommand == "message")
  if (!args)
    show = 1;
  elseif (trusts)
    message = $string_utils:from_list(args, " ");
    au.status_message = message;
    player:notify("Message set to:  " + message);
    if ($command_utils:yes_or_no("Notify users?"))
      notify = tostr("The ANSI status message was just set by ", player.name, "; type \"@ansi-status message\" to see it.");
      for x in (setremove($object_utils:leaves_suspended($ansi_pc), player))
        x:tell(notify);
      endfor
    endif
  else
    player:notify("The message can only be set by trusted users, type \"@ansi-status message\" to see the message.");
  endif
elseif (!trusts)
  player:notify(tostr("The subcommand \"", subcommand, "\" either doesn't exist or is limited to trusted users only."));
elseif (subcommand == "input")
  player:notify("What do you want to set the message to?");
  message = $command_utils:read_lines();
  au.status_message = message;
  player:notify("Message set to:");
  player:notify_lines(message);
  if ($command_utils:yes_or_no("Notify users?"))
    notify = tostr("The ANSI status message was just set by ", player.name, "; type \"@ansi-status message\" to see it.");
    for x in (setremove($object_utils:leaves_suspended($ansi_pc), player))
      x:notify(notify);
    endfor
  endif
elseif (subcommand == "clear")
  au.status_message = "";
  player:notify("Cleared status message.");
elseif (subcommand in {"activate", "active", "on"})
  player:notify(au.active ? "The ANSI system is already active." | "The ANSI system has been activated.");
  au.active = 1;
elseif (subcommand in {"deactivate", "deactive", "off"})
  player:notify(au.active ? "The ANSI system has been deactivated, type \"@ansi-status activate\" to reactivate it." | "The ANSI system is not active.");
  au.active = 0;
elseif (subcommand == "diagnostic")
  status = au:self_diagnostic(fix = index(tostr(@args), "fix"), player);
  player:notify(tostr("Diagnostic completed, ", fix ? "fixed" | "found", " ", status, " problem", status == 1 ? "" | "s", "."));
elseif (subcommand == "update")
  player:notify("Updating caches...");
  au:update_all();
  player:notify("Done updating caches.");
else
  player:notify("Invalid subcommand: " + subcommand);
endif
if (show)
  if (m = au.status_message)
    ml = player:linelen() - 14;
    lines = {};
    for a in (typeof(m) == LIST ? m | {m})
      for b in ($generic_editor:fill_string(a, ml))
        lines = {@lines, b};
      endfor
    endfor
    player:notify("ANSI message: " + lines[1]);
    for x in (listdelete(lines, 1))
      player:notify("              " + x);
    endfor
  else
    player:notify("There is no ANSI message set.");
  endif
endif
