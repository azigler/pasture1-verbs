#99:@ansi-setup   this none none rx

"Usage:  @ansi-setup <this>";
"Used to fix various core utilities to work with ANSI. This verb can only be used by a wizard, and needs wizperms to run.";
"Ugh, this verb is getting out of control, this stuff should all be moved to diagnostic tests.";
if (!player.wizard)
  player:tell("This verb was intended to fix up the rest of a MOO's core so it can function properly with the ANSI PC. If something's wrong, ask a wizard to set this up for you.");
elseif (!$code_utils:verb_perms().wizard)
  player:tell("This verb needs to be wizpermed before it can work.");
elseif (!$command_utils:yes_or_no("This will change various verbs in the core so they can be used with the ANSI PC, overwriting the previous verbs. Are you sure you want to do this?"))
  player:notify("Well, okay then.");
else
  set_task_perms(valid(cp = caller_perms()) ? cp | player);
  spiffy = 1;
  "----== Corify Objects ==----";
  for x in ({"help", "pc", "utils", "options"})
    prop = "ansi_" + x;
    if (!$object_utils:has_property($sysobj, prop))
      add_property($sysobj, prop, #-1, {player, "r"});
      player:notify(tostr("Creating a $", prop, " property."));
    endif
    if (valid($sysobj.(prop)))
    elseif (x == "utils")
      player:notify(tostr("Setting $", prop, " to ", $string_utils:nn(this), "."));
      $sysobj.(prop) = this;
    else
      objects = {};
      for o in ({@player.owned_objects || {}, @player.public_identity.owned_objects || {}, @player.contents || {}, @player.location.contents || {}})
        if (index(o.name, "ANSI") && index(o.name, strsub(x, "s", "")))
          objects = setadd(objects, o);
        endif
      endfor
      if (!objects)
        return player:notify(tostr("Unable to find $", prop, ", please port this object and set #0.", prop, " to it's object number. If you created a new player to own ANSI objects, you might want to temporarily set your .public_identity property to that player and rerun this verb. Remember to reset the property when you're done."));
      elseif (length(objects) == 1)
        player:notify(tostr("Setting $", prop, " to ", $string_utils:nn(objects[1]), "."));
        $sysobj.(prop) = objects[1];
      else
        return player:notify(tostr("Found ", length(objects), " objects that could be $", prop, ", please set #0.", prop, " to the object number of the correct one:  ", $string_utils:nn_list(objects)));
      endif
    endif
  endfor
  "----== Wizperm everything that should be ==----";
  for x in (this.need_wizperms)
    if (!(info = verb_info(y = $sysobj.(x[1]), x[2]))[1].wizard)
      player:notify(tostr("Wizperming $", x[1], ":", x[2], "..."));
      set_verb_info(y, x[2], listset(info, player, 1));
    endif
  endfor
  if (!($ansi_help in (typeof(ah = $ansi_pc.help) == LIST ? ah | {ah})))
    player:notify("Setting $ansi_pc.help...");
    $ansi_pc.help = $ansi_help;
  endif
  "----== Various core hacks ==----";
  su = $string_utils;
  if (!$object_utils:has_callable_verb(su, "redirect_ansi"))
    player:notify("Adding $string_utils:redirect_ansi...");
    add_verb(su, {$hacker, "rx", "redirect_ansi"}, {"this", "none", "this"});
    set_verb_code(su, "redirect_ansi", this.redirect_su_code);
  endif
  for x in (this.redirect_su_names)
    if ((info = verb_info(su, x)) && !index(info[3], "redirect_ansi"))
      nn = "";
      for y in ($string_utils:explode(info[3], " "))
        nn = tostr(nn, " ", y, "(noansi)");
      endfor
      set_verb_info(su, x, listset(info, $string_utils:triml(nn), 3));
      player:notify(tostr("Renaming $string_utils:\"", info[3], "\" to \"", nn, "\"..."));
    endif
  endfor
  redirect = $string_utils:from_list({"redirect_ansi", @this.redirect_su_names}, " ");
  if ((info = verb_info(su, "redirect_ansi"))[3] != redirect)
    player:notify(tostr("Renaming $string_utils:redirect_ansi to \"", redirect, "\"."));
    set_verb_info(su, "redirect_ansi", listset(info, redirect, 3));
  endif
  $command_utils:suspend_if_needed(0);
  !(length(vc = verb_code($login, "notify")) == 2 && index(vc[2], "$ansi_utils:delete")) && $command_utils:yes_or_no("Update $login:notify?") ? set_verb_code($login, "notify", {"(caller!=$ansi_utils)&&set_task_perms(caller_perms());notify(player,$ansi_utils:delete(args[1]));"}) || player:notify("$login:notify changed.") | (spiffy = 0) || player:notify("$login:notify left alone.");
  thatline = "line[1..min(width, length(line))]";
  newline = "$ansi_utils:cutoff(line,1,min(width,$ansi_utils:length(line)))";
  for x in ({"mail_agent", "big_mail_recipient"})
    vc = $string_utils:print(verb_code(y = $sysobj.(x), vn = "display_seq_headers"));
    player:notify(tostr("$", x, ":", vn, " ", index(vc, thatline) && $command_utils:yes_or_no(tostr("Replace \"", thatline, "\" in $", x, ":", vn, " with \"", newline, "\"?")) && set_verb_code(y, vn, $string_utils:to_value(strsub(vc, thatline, newline))[2]) == {} ? "changed." | (spiffy = 0) || "left alone."));
  endfor
  code = {};
  for x in (verb_code($login, "@who"))
    code = {@code, strsub(x, "$code_utils:show_who_listing", "$ansi_utils:show_who_listing")};
  endfor
  if (code != verb_code($login, "@who"))
    player:notify("Setting $login:@who...");
    set_verb_code($login, "@who", code);
  endif
  $command_utils:suspend_if_needed(0);
  code = {};
  for x in (verb_code($guest, "do_reset", 0, 0))
    if ((m = match(x, "^for x in (%(%{.+%}%))$")) && (info = $string_utils:to_value(substitute("%1", m)))[1])
      x = tostr("for x in (", $string_utils:print($set_utils:union(info[2], $ansi_utils.reset_guest_props)), ")");
    endif
    code = {@code, x};
    $command_utils:suspend_if_needed(0);
  endfor
  if (code != verb_code($guest, "do_reset", 0, 0))
    player:notify("Setting $guest:do_reset...");
    set_verb_code($guest, "do_reset", code);
  endif
  code = {};
  for x in (verb_code($prog, "@list", 0, 0))
    if (code == 0)
    elseif (index(x, "$ansi_utils:add_noansi("))
      code = 0;
    elseif (index(x, "player:notify(tostr(what, \":\", fullname, \"") == 1)
      code = {@code, "$ansi_utils:add_noansi();", x};
    else
      code = {@code, x};
    endif
    $command_utils:suspend_if_needed(0);
  endfor
  if (code && code != verb_code($prog, "@list", 0, 0))
    player:notify("Setting $prog:@list...");
    set_verb_code($prog, "@list", code);
  endif
  code = {};
  a = {0, 0};
  for x in (verb_code($generic_editor, "list_line"))
    a[1] = a[1] || index(x, "$ansi_utils:add_noansi(");
    a[2] = a[2] || index(x, "$ansi_utils:remove_noansi(");
    code = {@code, x};
    $command_utils:suspend_if_needed(0);
  endfor
  a[1] || (code = {"$ansi_utils:add_noansi();", @code});
  a[2] || (code = {@code, "$ansi_utils:remove_noansi();"});
  if (code != verb_code($generic_editor, "list_line"))
    player:notify("Setting $generic_editor:list_line...");
    set_verb_code($generic_editor, "list_line", code);
  endif
  $command_utils:suspend_if_needed(0);
  if (!$object_utils:defines_verb($player_db, "insert"))
    player:notify("Adding $player_db:insert...");
    add_verb($player_db, {player, "rxd", "insert"}, {"this", "none", "this"});
    set_verb_code($player_db, "insert", this.plr_db_insert);
  elseif (verb_code($player_db, "insert") != this.plr_db_insert)
    player:notify("$player_db:insert already exists, you will have to edit it manually for the ANSI, see $ansi_utils.plr_db_insert for sample code.");
  endif
  if (verb_code($generic_editor, "fill_string") != this.ge_fill_string)
    a = "";
    while ($object_utils:has_verb($generic_editor, vname = tostr("fill_string(noansi", a, ")")))
      a = toint(a) + 1;
    endwhile
    set_verb_info($generic_editor, "fill_string", listset(verb_info($generic_editor, "fill_string"), vname, 3));
    add_verb($generic_editor, {player, "rx", "fill_string"}, {"this", "none", "this"}) || player:notify("Adding new $generic_editor:fill_string...");
    set_verb_code($generic_editor, "fill_string", this.ge_fill_string);
  endif
  "...ugh, I want to put $prog:@dump in here but the one I put on NestMOO is too big to search...";
  "----== Set the non-printable characters ==----";
  $command_utils:suspend_if_needed(0);
  for x in ({{"escape", 27, "033"}, {"beep", 7, "007"}})
    chr = x[1];
    code = x[2];
    octal = x[3];
    if (typeof(this.(chr)) != STR || length(this.(chr)) != 1)
      if (eval(";return chr(64);")[1])
        player:notify(tostr("Setting $ansi_utils.", chr, " with chr()..."));
        eval(tostr(";$ansi_utils.(\"", chr, "\")=chr(", code, ");"));
      elseif ((eval = eval(";return filelist(\"\", \"\");"))[1] || (eval = eval(";return file_list(\"\");"))[1])
        files = typeof(eval[2][1]) == LIST ? eval[2][1] | eval[2];
        if (chr + ".chr" in files)
          player:notify(tostr("Setting $ansi_utils.", chr, " from file ", chr, ".chr..."));
          if (typeof(eval[2][1]) == LIST)
            "Setup for FUP";
            eval(tostr(";$ansi_utils.(\"", chr, "\")=fileread(\"\", \"", chr, ".chr\")[1];"));
          else
            "Setup for FIO";
            handle = file_open(tostr("/", chr, ".chr"), "r-tn");
            $ansi_utils.(chr) = file_readline(handle);
            file_close(handle);
          endif
        else
          player:notify(tostr("File builtin detected, please create a file named \"", chr, ".chr\" in the files directory and put an ASCII character ", code, " in it.  This can be done on most systems with the command:  echo -e '\\", octal, "' > ", chr, ".chr  from the files directory."));
          spiffy = 0;
        endif
      else
        z = this.(chr) = tostr("<----- ", $string_utils:uppercase(chr), " ----->");
        player:notify(tostr("I can't find any way to set $ansi_utils.", chr, ", please either install the FUP, FileIO, or chr() server patches and rerun this verb, or shut down the MOO, load the DB into an editor, and replace \"", z, "\" with an ASCII character ", code, "."));
        spiffy = 0;
      endif
    endif
  endfor
  if (this.active)
    player:notify("@ansi-setup finished.");
  elseif (!spiffy)
    player:notify("@ansi-setup can not verify that everything has been set up correctly, you will probably have to rerun this verb.  If you're sure everything is correct, you can type:  ;;$ansi_utils.active=1;  to activate it.");
  elseif ($command_utils:yes_or_no("Everything seems to be set up correctly, activate the ANSI system?"))
    this.active = 1;
    "...raw notify() the first message in case it breaks, we're wizpermed anyway...";
    notify(player, "The ANSI system is now active, it can be deactivated by typing: ;;$ansi_utils.active = 0;");
    player:notify(tostr("Welcome to ANSI version ", this.version, "."));
  else
    player:notify("Not activating the ANSI system, you can do this manually by typing: ;;$ansi_utils.active = 1;  when you're sure everything's set up correctly.");
  endif
endif
