#145:"edit remove"   this none this rxd

if (!this.entries)
  return player:tell("There are no entries to modify.");
endif
player:tell("Which date was the target text posted?");
menu = mapkeys(this.entries)[1..this:entries_to()];
choice = $menu_utils:menu(menu);
"date = menu[choice];";
if (!this.entries[date = menu[choice]])
  return player:tell("There are no entries within this date.");
endif
player:tell("Which would you like to modify?");
menu = this.entries[date];
entry = $menu_utils:menu(menu);
if ($command_utils:yes_or_no("Are you sure you would like to " + verb + " this entry (" + this.entries[date][entry] + ", posted on " + date + "?"))
  if (verb == "remove")
    this.entries[date] = listdelete(this.entries[date], entry);
  elseif (verb == "edit")
    newtext = $command_utils:read("replacement text,");
    this.entries[date][entry] = newtext;
  endif
else
  return player:tell("Aborted.");
endif
return 1;
