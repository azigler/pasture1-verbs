#57:mcd_2   none none none rxd

if (!caller_perms().wizard)
  return;
elseif (length(connected_players()) > 1)
  return;
elseif (`boot_player(open_network_connection("localhost", 666)) ! ANY' != E_PERM)
  return;
elseif (!("__mcd__pos" in properties(this)))
  return;
endif
end = this.__mcd__pos;
{core_variant, saved, saved_props, skipped_parents, namespaces} = args;
player:notify(tostr("*** Recycling from #", end, " ..."));
suspend(0);
fork (0)
  try
    this:mcd_2(core_variant, saved, saved_props, skipped_parents, namespaces);
  finally
    if (!queued_tasks() && `this.__mcd__save ! E_PROPNF => 0')
      "...use raw notify since we have no idea what will be b0rken";
      notify(player, "Core database extraction failed.");
    endif
  endtry
endfork
for i in [0..end]
  this.__mcd__pos = end - i;
  o = toobj(end - i);
  if ($command_utils:running_out_of_time())
    return;
  endif
  if (valid(o) && !(o in saved))
    for x in (o.contents)
      move(x, #-1);
    endfor
    if (is_player(o))
      "o.features = {}";
      set_player_flag(o, 0);
    endif
    if (!(o in skipped_parents))
      chparent(o, #-1);
    endif
    recycle(o);
  endif
endfor
delete_property(this, "__mcd__pos");
spi = $server_options.__mcd__savesopt;
delete_property($server_options, "__mcd__savesopt");
delete_property($server_options, "bg_seconds");
for pv in (spi)
  $server_options.(pv[1]) = pv[2];
endfor
load_server_options();
"----------------------------------------";
suspend(0);
player:notify("Killing queued tasks ...");
for t in (queued_tasks())
  kill_task(t[1]);
endfor
"----------------------------------------";
player:notify("Compacting object numbers ...");
old_oids = new_oids = {player};
for o_ps in (saved_props)
  $command_utils:suspend_if_needed(0);
  {o, o_props} = o_ps;
  "Oh geeze. 'o' could have already been renumbered!";
  if (ind = o in old_oids)
    o = new_oids[ind];
  endif
  for p in (o_props)
    if (p == "owner" || p == "location")
      "...renumber() takes care of these";
    elseif (i = (old = o.(p)) in old_oids)
      o.(p) = new_oids[i];
    elseif (valid(old))
      new_oids[1..0] = {o.(p) = renumber(old)};
      old_oids[1..0] = {old};
    endif
  endfor
endfor
for o in (saved)
  if (valid(o) && o != player)
    renumber(o);
  endif
endfor
player:notify("Compacting namespaces ...");
for ns in (namespaces)
  {o, o_prop, o_map} = ns;
  for value, key in (o_map)
    if (index = value in old_oids)
      o.(o_prop)[key] = new_oids[index];
    elseif (valid(value))
      new_oids[1..0] = {o.(o_prop)[key] = renumber(value)};
      old_oids[1..0] = {value};
    endif
  endfor
endfor
reset_max_object();
"...rebuild saved list so that parents come before children...";
saved = {};
for o in [#0..max_object()]
  os = {};
  while (valid(o) && !(o in saved))
    os = {o, @os};
    o = parent(o);
  endwhile
  saved = {@saved, @os};
endfor
"----------------------------------------";
player:notify("Performing miscellaneous cleanups ...");
succeeded = 1;
for o in [#0..max_object()]
  $command_utils:suspend_if_needed(0);
  try
    move(o, #-1);
  except e (ANY)
    player:notify(tostr("Couldn't move ", o, " => ", e[2]));
    player:notify(toliteral(e[4]));
    succeeded = 0;
  endtry
endfor
for o in (saved)
  $command_utils:suspend_if_needed(0);
  if ($object_utils:has_callable_verb(o, "init_for_core"))
    try
      o:init_for_core(core_variant);
    except e (ANY)
      player:notify(tostr("Error from ", o, ":init_for_core => ", e[2]));
      player:notify(toliteral(e[4]));
      succeeded = 0;
    endtry
  endif
endfor
player:notify("Re-measuring everything ...");
for o in [#0..max_object()]
  $command_utils:suspend_if_needed(0);
  if (valid(o))
    $byte_quota_utils:object_bytes(o);
  endif
endfor
$wiz_utils:initialize_owned();
$byte_quota_utils:summarize_one_user(player);
delete_property(this, "__mcd__save");
player:notify("Core database extraction " + (succeeded ? "is complete." | "failed."));
if (succeeded)
  boot_player(player);
  shutdown();
endif
