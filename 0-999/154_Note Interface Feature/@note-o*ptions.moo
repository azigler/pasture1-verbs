#154:@note-o*ptions   any any any rxd

"View and set options pertinent to the note feature.";
"Each option should have the keys: Name, help_msg, add_msg, and remove_msg.";
options = [];
options["debug"] = ["name" -> "Debug Mode", "help_msg" -> "Toggles the display of certain debugging information, such as note and folder IDs displayed beside their names.", "remove_msg" -> "You will no longer see debug information.", "add_msg" -> "You will now see debug information."];
options["full_tree"] = ["name" -> "Show Entire Tree At Once", "help_msg" -> "When enabled, you will see the entire hierarchy at one time. This means every branch of every folder and sub-folder and their notes.", "remove_msg" -> "You will no longer see the entire hierarchy when viewing notes.", "add_msg" -> "You will now see the entire hierarchy when viewing notes."];
options["show_all_occurances"] = ["name" -> "Show All Referenced Note Folders", "help_msg" -> "It's possible for a single note to exist in multiple folders. When searching for notes, this option controls whether you'll see every instance of a single note in each of its folders or if you will only see each unique note one time.", "add_msg" -> "You will now see every occurance of a note in search results.", "remove_msg" -> "You will now only see unique notes once in search results."];
options["announce_notes"] = ["name" -> "Announce Changes to Notes", "help_msg" -> "You'll receive a notification any time somebody adds, deletes, or edits a note.", "add_msg" -> "You will now receive notifications when people add, delete, or edit notes.", "remove_msg" -> "You will no longer receive notifications when people add, delete, or edit notes.", "property" -> "architect_options"];
if (!maphaskey(this.utils.options, player))
  this.utils.options[player] = {};
endif
menu = option_names = {};
on = "[[green]On[normal]]";
off = "[[red]Off[normal]]";
count = 0;
current_options = this.utils.options[player];
for value, key in (options)
  count = count + 1;
  property = maphaskey(value, "property") ? player.(value["property"]) | current_options;
  menu = {@menu, {tostr("[", count, "]"), value["name"], key in property ? on | off}};
  "Option_names for :options_menu to search through.";
  option_names = {@option_names, value["name"]};
endfor
"Grab the list of keys so we can match a number to a key.";
keys = mapkeys(options);
while (1)
  if (!argstr)
    player:tell_lines($string_utils:autofit(menu));
    player:tell();
    player:tell("Enter your selection. If you need help, type `HELP <option number>' to get more information.");
    choice = $command_utils:read();
  else
    choice = argstr;
  endif
  words = explode(choice);
  if (words == {})
    return player:tell("Invalid selection.");
  elseif (words[1] in {"help", "?"})
    option = toint(words[2]);
    if (option <= 0 || option > length(options))
      player:tell("Invalid option.");
    else
      option = keys[option];
      player:tell(options[option]["name"], ": ", options[option]["help_msg"]);
      suspend(0.5);
      player:tell();
    endif
  else
    if ($string_utils:is_numeric(choice))
      choice = toint(choice);
      if (choice <= 0 || choice > length(options))
        return player:tell("Invalid selection.");
      else
        result = choice;
      endif
    else
      result = $menu_utils:options_menu(option_names, choice);
      if (result == 0)
        return;
      endif
    endif
    option = keys[result];
    if (maphaskey(options[option], "property"))
      property = options[option]["property"];
      if (option in player.(property))
        player:tell(options[option]["remove_msg"]);
        player.(property) = setremove(player.(property), option);
      else
        player:tell(options[option]["add_msg"]);
        player.(property) = setadd(player.(property), option);
      endif
    else
      if (option in this.utils.options[player])
        player:tell(options[option]["remove_msg"]);
        this.utils.options[player] = setremove(this.utils.options[player], option);
      else
        player:tell(options[option]["add_msg"]);
        this.utils.options[player] = setadd(this.utils.options[player], option);
      endif
    endif
    return;
  endif
endwhile
