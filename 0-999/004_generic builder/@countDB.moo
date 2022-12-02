#4:@countDB   any none none rd

if (!dobjstr)
  dobj = player;
elseif ($command_utils:player_match_result(dobj = $string_utils:match_player(dobjstr), dobjstr)[1])
  return;
endif
set_task_perms(player);
count = 0;
for o in [#1..max_object()]
  if ($command_utils:running_out_of_time())
    player:notify("Counting...");
    suspend(5);
  endif
  if (valid(o) && o.owner == dobj)
    count = count + 1;
  endif
endfor
player:notify(tostr(dobj.name, " currently owns ", count, " object", count == 1 ? "." | "s."));
