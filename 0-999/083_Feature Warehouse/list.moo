#83:list   any (in/inside/into) this rxd

"Copied from Features Feature Object (#24300):list by Joe (#2612) Mon Oct 10 21:07:35 1994 PDT";
if (this.contents)
  player:tell(".features objects:");
  player:tell("----------------------");
  first = 1;
  for thing in (this.contents)
    $command_utils:kill_if_laggy(10, "Sorry, the MOO is very laggy, and there are too many feature objects in here to list!");
    $command_utils:suspend_if_needed(0);
    if (!first)
      player:tell();
    endif
    player:tell($string_utils:nn(thing), ":");
    `thing:look_self() ! ANY => player:tell("<<Error printing description>>")';
    first = 0;
  endfor
  player:tell("----------------------");
else
  player:tell("No objects in ", this.name, ".");
endif
