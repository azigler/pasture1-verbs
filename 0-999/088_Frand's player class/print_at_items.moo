#88:print_at_items   this none this rxd

"'print_at_items (<locations>, <parties>)' - Print a list of locations and people, for @at. Override this if you want to make a change to @at's output that you can't make in :at_item.";
{locations, parties} = args;
for i in [1..length(locations)]
  $command_utils:suspend_if_needed(0);
  player:tell_lines(this:at_item(locations[i], parties[i]));
endfor
