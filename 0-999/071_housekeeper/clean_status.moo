#71:clean_status   this none this rxd

count = 0;
for i in (this.requestors)
  if (i == player)
    count = count + 1;
  endif
  $command_utils:suspend_if_needed(1);
endfor
player:tell("Number of items in cleanup list: ", tostr(length(this.clean)));
player:tell("Number of items you requested to be tidied: ", tostr(count));
player:tell("Number of requestors: ", tostr(length($list_utils:remove_duplicates(this.requestors))));
player:tell("Time to complete one cleaning circuit: ", $time_utils:english_time(length(this.clean) * this:time()));
player:tell("The Housekeeper is in " + ($housekeeper.testing == 0 ? "normal, non-testing mode." | "testing mode. "));
if (!$code_utils:task_valid($housekeeper.task))
  player:tell("The Housekeeper task has died. Restarting...");
  $housekeeper:continuous();
else
  player:tell("The Housekeeper is actively cleaning.");
endif
