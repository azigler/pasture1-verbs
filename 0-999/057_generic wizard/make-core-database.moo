#57:make-core-database   any none none rd

{?core_variant_name = ""} = args;
if (!player.wizard)
  player:notify("Nice try, but permission denied.");
  return;
elseif (length(connected_players()) > 1)
  player:notify("You need to @boot everybody else before I'll believe this isn't the real MOO.");
  abort = 1;
elseif (`boot_player(open_network_connection("localhost", 666)) ! ANY' != E_PERM)
  player:notify("Why are outbound connections enabled?  I bet this is the real MOO.");
  abort = 1;
else
  abort = !$command_utils:yes_or_no("Continuing with this command will destroy all but the central core of the database.  Are you sure you want to do this?  ") || !$command_utils:yes_or_no("Really sure? ");
endif
if (abort)
  player:notify("Core database extraction aborted.");
  return;
endif
"----------------------------------------";
player:notify("Messing with server options...");
spi = {};
for p in ({"protect_recycle", "protect_set_property_info", "protect_add_property", "protect_chparent", "bg_ticks"})
  spi = {@spi, {p, $server_options.(p)}};
  $server_options.(p) = 0;
endfor
$server_options.bg_ticks = 1000000;
add_property($server_options, "bg_seconds", 7, {player, "r"});
`load_server_options() ! ANY';
add_property($server_options, "__mcd__savesopt", spi, {player, "r"});
"----------------------------------------";
player:notify("Killing all queued tasks ...");
for t in (queued_tasks())
  kill_task(t[1]);
endfor
suspend(0);
"----------------------------------------";
player:notify(tostr("Identifying objects to be saved", @core_variant_name ? {" for core variant '", core_variant_name, "'"} | {}, " ..."));
"... TODO --- core variant name lookup?";
core_variant = {{"name", core_variant_name}};
{saved, saved_props, skipped_parents, proxy_original, proxy_incore, namespaces} = $core_object_info(core_variant, 1);
if (!(player in saved))
  player:notify("Sorry, but this won't work unless you yourself are on the list of objects to be saved.");
  player:notify("Core database extraction aborted.");
  return;
endif
for ops in (saved_props)
  {o, o_props} = ops;
  for p in (o_props)
    if (i = o.(p) in proxy_original)
      o.(p) = proxy_incore[i];
    endif
  endfor
endfor
"... TODO --- why isn't this on #0:init_for_core ? --Rog";
$player_class = $mail_recipient_class;
"----------------------------------------";
player:notify("Stripping you of any personal verbs and/or properties ...");
for i in [1..length(verbs(player))]
  delete_verb(player, 1);
endfor
for p in (properties(player))
  delete_property(player, p);
endfor
chparent(player, $wiz);
for p in ($object_utils:all_properties(player))
  clear_property(player, p);
endfor
player:set_name("Wizard");
player:set_aliases({"Wizard"});
player.description = "";
player.key = 0;
player.ownership_quota = 100;
player.password = 0;
player.last_password_time = 0;
$gender_utils:set(player, "neuter");
"----------------------------------------";
suspend(0);
owners_original = owners_incore = {};
for i in [1..length(proxy_original)]
  o = proxy_original[i];
  if (is_player(o) && o != $no_one)
    owners_original = {@owners_original, o};
    owners_incore = {@owners_incore, proxy_incore[i]};
  endif
endfor
for o in (saved)
  if (is_player(o) && o != $no_one)
    owners_original = {@owners_original, o};
    owners_incore = {@owners_incore, o};
  endif
endfor
player:notify(tostr("Chowning every saved object, verb and property to one of ", $string_utils:nn(owners_incore), "..."));
for o in (saved)
  $command_utils:suspend_if_needed(0, "... ", length(saved) - (o in saved), " to go");
  if (i = o.owner in owners_original)
    o.owner = owners_incore[i];
  elseif (valid(o.owner) && o.owner.wizard)
    o.owner = player;
  else
    o.owner = $hacker;
  endif
  old_verbs = {};
  for j in [1..length(verbs(o))]
    $command_utils:suspend_if_needed(0, "... ", length(saved) - (o in saved), " to go");
    info = verb_info(o, j);
    if (i = info[1] in owners_original)
      info[1] = owners_incore[i];
    elseif (valid(info[1]) && info[1].wizard)
      info[1] = player;
    else
      info[1] = $hacker;
    endif
    set_verb_info(o, j, info);
    if (index(info[3], "(old)"))
      old_verbs = {j, @old_verbs};
    endif
  endfor
  for vname in (old_verbs)
    delete_verb(o, vname);
  endfor
  for p in ($object_utils:all_properties(o))
    $command_utils:suspend_if_needed(0, "... ", length(saved) - (o in saved), " to go");
    info = property_info(o, p);
    if (i = info[1] in owners_original)
      info[1] = owners_incore[i];
    elseif (valid(info[1]) && info[1].wizard)
      info[1] = player;
    else
      info[1] = $hacker;
    endif
    set_property_info(o, p, info);
  endfor
endfor
"----------------------------------------";
player:notify("Removing all unsaved :recycle, :exitfunc, and :recycle verbs ...");
for o in [#0..max_object()]
  $command_utils:suspend_if_needed(0, "... ", o);
  if (valid(o) && !(o in saved))
    for v in ({"recycle", "exitfunc", "recycle"})
      while ($object_utils:defines_verb(o, v))
        delete_verb(o, v);
      endwhile
    endfor
  endif
endfor
"----------------------------------------";
player:notify("Recycling unsaved objects ...");
add_property(this, "__mcd__pos", toint(max_object()), {player, "r"});
add_property(this, "__mcd__save", {core_variant, saved, saved_props, skipped_parents, namespaces}, {player, "r"});
suspend(0);
try
  this:mcd_2(core_variant, saved, saved_props, skipped_parents, namespaces);
finally
  if (!queued_tasks() && `this.__mcd__save ! E_PROPNF => 0')
    "...use raw notify since we have no idea what will be b0rken";
    notify(player, "Core database extraction failed.");
  endif
endtry
