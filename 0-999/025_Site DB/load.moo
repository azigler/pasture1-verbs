#25:load   this none this rxd

":load([start]) -- reloads site_db with the connection places of all players.";
"This routine calls suspend() if it runs out of time.";
"WIZARDLY";
"...needs to be able to read .all_connect_places";
if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
endif
plist = players();
if (!args)
  this:clearall();
elseif (i = args[1] in plist)
  plist[1..i - 1] = {};
else
  return E_INVARG;
endif
for p in (plist)
  if (valid(p) && (is_player(p) && !$object_utils:isa(p, $guest)))
    "... player may be recycled or toaded during the suspend(),...";
    "... guests login from everywhere...";
    for c in (p.all_connect_places)
      this:add(p, c);
      if ($command_utils:running_out_of_time())
        player:tell("...", p);
        suspend(0);
      endif
    endfor
  endif
endfor
