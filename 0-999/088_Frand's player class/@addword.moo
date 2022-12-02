#88:@addword   any any any rd

set_task_perms(player);
if (!argstr)
  player:notify(tostr("Usage: ", verb, " one or more words"));
  player:notify(tostr("       ", verb, " object:verb"));
  player:notify(tostr("       ", verb, " object.prop"));
elseif (!$perm_utils:controls(player, player))
  player:notify("Cannot modify dictionary on players who do not own themselves.");
elseif (data = $spell:get_input(argstr))
  num_learned = 0;
  for i in [1..length(data)]
    line = $string_utils:words(data[i]);
    for ii in [1..length(line)]
      if (seconds_left() < 2)
        suspend(0);
      endif
      if (!$spell:valid(line[ii]))
        player.dict = listappend(player.dict, line[ii]);
        player:notify(tostr("Word added:  ", line[ii]));
        num_learned = num_learned + 1;
      endif
    endfor
  endfor
  player:notify(tostr(num_learned ? num_learned | "No", " word", num_learned != 1 ? "s " | " ", "added to personal dictionary."));
endif
