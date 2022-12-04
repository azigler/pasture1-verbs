#6:autoafk-o*ptions   any none none xd

options = this.autoafk_options;
menu = {["name" -> "Automatically go AFK After a Period of Inactivity", "identifier" -> "auto_afk", "state" -> options["auto_afk"]], ["name" -> "Automatically Return from AFK When Sending a Command", "identifier" -> "auto_unafk", "state" -> options["auto_unafk"]], ["name" -> "Maximum Time of Inactivity Before Going AFK", "identifier" -> "max_time", "state" -> $time_utils:english_time(options["max_time"])]};
choice = $menu_utils:options_menu(menu);
value = options[choice];
if (choice in {"auto_afk", "auto_unafk"})
  value = !value;
  if (choice == "auto_afk")
    player:tell("You will ", value == 1 ? "now" | "no longer", " automatically go AFK after a period of inactivity.");
  elseif (choice == "auto_unafk")
    player:tell("You will ", value == 1 ? "now" | "no longer", " automatically return from AFK when sending a command.");
  endif
else
  player:tell("Enter how long (in minutes) the MOO should take to set you as AFK.");
  value = `toint($command_utils:read()) * 60 ! ANY => 600';
  if (value < 1)
    return player:tell("Try at least 1 minute, dude.");
  else
    player:tell("Maximum time of inactivity set to ", $time_utils:english_time(value), ". Be advised that this might be delayed slightly.");
  endif
endif
options[choice] = value;
this.autoafk_options = options;
"Last modified Sun Dec  4 04:43:08 2022 UTC by Saeed (#128).";
