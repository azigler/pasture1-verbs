#4:@quota   any none none rd

set_task_perms(player);
if (dobjstr == "")
  dobj = player;
else
  dobj = $string_utils:match_player(dobjstr);
endif
if (!valid(dobj))
  player:notify("Show whose quota?");
  return;
endif
$quota_utils:display_quota(dobj);
try
  if (dobj in $local.informed_quota_consumers.uninformed_quota_consumers)
    player:notify(tostr("Note that quota is held in escrow -- `look ", $local.informed_quota_consumers, "' for more details."));
  endif
except id (ANY)
endtry
