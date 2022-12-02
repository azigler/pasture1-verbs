#57:"@blacklist @graylist @redlist @unblacklist @ungraylist @unredlist @spooflist @unspooflist"   any any any rd

"@[un]blacklist [<site or subnet>  [for <duration>] [commentary]]";
"@[un]graylist  [<site or subnet>  [for <duration>] [commentary]]";
"@[un]redlist   [<site or subnet>  [for <duration>] [commentary]]";
"@[un]spooflist [<site of subnet>  [for <duration>] [commentary]]";
"The `for <duration>' is for temporary colorlisting a site only. The duration should be in english time units:  for 1 hour, for 1 day 2 hours 15 minutes, etc. The commentary should be after all durations. Note, if you are -not- using a duration, do not start your commentary with the word `for'.";
set_task_perms(player);
if (player != this || !player.wizard)
  player:notify("Ummm.  no.");
  return;
endif
undo = verb[2..3] == "un";
which = $login:listname(verb[undo ? 4 | 2]);
downgrade = {"", "graylist", "blacklist"}[1 + index("br", which[1])];
if (!(fw = $string_utils:first_word(argstr)))
  "... Just print the list...";
  this:display_list(which);
  return;
endif
target = fw[1];
if (fw[2] && (parse = this:parse_templist_duration(fw[2]))[1])
  if (typeof(parse[3]) == ERR || !parse[3])
    player:notify(tostr("Could not parse the duration for @", which, "ing site \"", target, "\""));
    return;
  endif
  start = parse[2];
  duration = parse[3];
  comment = parse[4] ? {parse[4]} | {};
  comment = {tostr("for ", $time_utils:english_time(duration)), @comment};
elseif (fw[2])
  comment = {fw[2]};
else
  "Get the right vars set up as though parse had been called";
  parse = {0, ""};
  comment = {};
endif
player:tell("comment is currently ", toliteral(comment));
if (is_literal = $site_db:domain_literal(target))
  if (target[$] == ".")
    target = target[1..$ - 1];
  endif
  fullname = "subnet " + target;
else
  if (target[1] == ".")
    target[1..1] = "";
  endif
  fullname = "domain `" + target + "'";
endif
entrylist = $login.(which)[1 + !is_literal];
if (!undo && target in entrylist)
  player:notify(tostr(fullname, " is already ", which, "ed."));
  return;
endif
entrylist = setremove(entrylist, target);
if (!(result = this:check_site_entries(undo, which, target, is_literal, entrylist))[1])
  return;
endif
rm = result[2];
namelist = $string_utils:english_list(rm);
downgraded = {};
if (rm)
  ntries = length(rm) == 1 ? "ntry" | "ntries";
  if ($command_utils:yes_or_no(tostr("Remove e", ntries, " for ", namelist, "?")))
    dg = undo && (downgrade && $command_utils:yes_or_no(downgrade + " them?"));
    for s in (rm)
      $login:(which + "_remove")(s);
      dg && ($login:(downgrade + "_add")(s) && (downgraded = {@downgraded, s}));
    endfor
    player:notify(tostr("E", ntries, " removed", @dg ? {" and ", downgrade, "ed."} | {"."}));
  else
    player:notify(tostr(namelist, " will continue to be ", which, "ed."));
    rm = {};
  endif
endif
if (downgraded)
  comment[1..0] = {tostr(downgrade, "ed ", $string_utils:english_list(downgraded), ".")};
endif
tempentrylist = $login.("temporary_" + which)[1 + !is_literal];
if (!undo && target in $list_utils:slice(tempentrylist))
  player:notify(tostr(fullname, " is already temporarily ", which, "ed."));
  return;
endif
if (en = $list_utils:assoc(target, tempentrylist))
  tempentrylist = setremove(tempentrylist, en);
endif
if (!(result = this:check_site_entries(undo, which, target, is_literal, $list_utils:slice(tempentrylist)))[1])
  return;
endif
rmtemp = result[2];
tempnamelist = $string_utils:english_list(rmtemp);
tempdowngraded = {};
if (rmtemp)
  ntries = length(rmtemp) == 1 ? "ntry" | "ntries";
  if ($command_utils:yes_or_no(tostr("Remove e", ntries, " for ", tempnamelist, "?")))
    dg = undo && (downgrade && $command_utils:yes_or_no(downgrade + " them?"));
    for s in (rmtemp)
      old = $list_utils:assoc(s, tempentrylist);
      $login:(which + "_remove_temp")(s);
      dg && ($login:(downgrade + "_add_temp")(s, old[2], old[3]) && (tempdowngraded = {@tempdowngraded, s}));
    endfor
    player:notify(tostr("E", ntries, " removed", @dg ? {" and ", downgrade, "ed with durations transferred."} | {"."}));
  else
    player:notify(tostr(tempnamelist, " will continue to be temporarily ", which, "ed."));
    rmtemp = {};
  endif
endif
if (tempdowngraded)
  comment[1..0] = {tostr(downgrade, "ed ", $string_utils:english_list(tempdowngraded), ".")};
endif
if (!undo)
  if (parse[1])
    $login:(which + "_add_temp")(target, start, duration);
    player:notify(tostr(fullname, " ", which, "ed for ", $time_utils:english_time(duration)));
  else
    $login:(which + "_add")(target);
    player:notify(tostr(fullname, " ", which, "ed."));
  endif
  if (rm)
    comment[1..0] = {tostr("Subsumes ", which, "ing for ", namelist, ".")};
  endif
  if (rmtemp)
    comment[1..0] = {tostr("Subsumes temporary ", which, "ing for ", tempnamelist, ".")};
  endif
elseif ($login:(which + "_remove")(target))
  player:notify(tostr(fullname, " un", which, "ed."));
  if (!downgrade)
  elseif ($command_utils:yes_or_no(downgrade + " it?"))
    $login:(downgrade + "_add")(target) && (downgraded = {target, @downgraded});
    player:notify(tostr(fullname, " ", downgrade, "ed."));
  else
    player:notify(tostr(fullname, " not ", downgrade, "ed."));
  endif
  if (downgraded)
    player:tell("Comment currently: ", toliteral(comment), " ; downgrade = ", toliteral(downgrade), " ; downgraded = ", toliteral(downgraded));
    comment[1..0] = {tostr(downgrade, "ed ", $string_utils:english_list(downgraded), ".")};
  endif
  if (rm)
    comment[1..0] = {tostr("Also removed ", namelist, ".")};
  endif
elseif ((old = $list_utils:assoc(target, $login.("temporary_" + which)[1 + !is_literal])) && $login:(which + "_remove_temp")(target))
  player:notify(tostr(fullname, " un", which, "ed."));
  if (!downgrade)
  elseif ($command_utils:yes_or_no(downgrade + " it?"))
    $login:(downgrade + "_add_temp")(target, old[2], old[3]) && (tempdowngraded = {target, @tempdowngraded});
    player:notify(tostr(fullname, " ", downgrade, "ed, currently for ", $time_utils:english_time(old[3]), " from ", $time_utils:time_sub("$1/$3", old[2])));
  else
    player:notify(tostr(fullname, " not ", downgrade, "ed."));
  endif
  if (tempdowngraded)
    comment[1..0] = {tostr(downgrade, "ed ", $string_utils:english_list(tempdowngraded), "with durations transferred.")};
  endif
  if (rmtemp)
    comment[1..0] = {tostr("Also removed ", tempnamelist, ".")};
  endif
elseif (rm || rmtemp)
  player:notify(tostr(fullname, " itself was never actually ", which, "ed."));
  comment[1..0] = {tostr("Removed ", namelist, " from regular and ", tempnamelist, " from temporary.")};
else
  player:notify(tostr(fullname, " was not ", which, "ed before."));
  return;
endif
subject = tostr(undo ? "@un" | "@", which, " ", fullname);
$mail_agent:send_message(player, $site_log, subject, comment);
"...";
"... make sure we haven't screwed ourselves...";
uhoh = {};
for site in (player.all_connect_places)
  if (index(site, target) && $login:(which + "ed")(site))
    uhoh = {@uhoh, site};
  endif
endfor
if (uhoh)
  player:notify(tostr("WARNING:  ", $string_utils:english_list(uhoh), " are now ", which, "ed!"));
endif
