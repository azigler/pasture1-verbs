#57:@shout   any any any rd

if (caller != this)
  raise(E_PERM);
endif
set_task_perms(player);
if (length(args) == 1 && argstr[1] == "\"")
  argstr = args[1];
endif
shout = $gender_utils:get_conj("shouts", player);
for person in (connected_players())
  if (person != player)
    person:notify(tostr(player.name, " ", shout, ", \"", argstr, "\""));
  endif
endfor
player:notify(tostr("You shout, \"", argstr, "\""));
