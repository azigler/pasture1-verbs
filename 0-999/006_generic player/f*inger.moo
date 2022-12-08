#6:f*inger   any any any rxd

{?arg = "me"} = args;
if (arg in {"customize"})
  menu = {};
  for i in (player.custom_profile_info)
    menu = {@menu, i[1]};
  endfor
  menu = {@menu, "add a field", "remove a field"};
  player:tell("You have ", this.custom_profile_info:length(), " custom profile fields.");
  choice = $menu_utils:menu(menu);
  if (choice == length(menu) - 1)
    fieldtitle = $command_utils:read("the field's title,");
    field = $command_utils:read("the text this field contains,");
    this.custom_profile_info = setadd(this.custom_profile_info, {fieldtitle, field});
    return player:tell("Added successfully.");
  elseif (choice == length(menu))
    if (length(this.custom_profile_info) == 0)
      return player:tell("You have no custom profile fields to remove.");
    else
      menu = this.custom_profile_info;
      choice = $menu_utils:menu(menu);
      this.custom_profile_info = listdelete(this.custom_profile_info, choice);
      return player:tell("Deleted.");
    endif
  else
    field = $command_utils:read("the new field text,");
    this.custom_profile_info[choice][2] = field;
    return player:tell("Successfully set to " + field + ".");
  endif
endif
who = $string_utils:match_player(arg);
if (who in {#-1, #-2, #-3})
  return player:tell("This is not a valid player.");
endif
info = {{"name", who.name}, {"gender", who.gender}, `{"last performed command", $time_utils:english_time(idle_seconds(who)) + " ago"} ! ANY => {"last connected", $time_utils:english_time(abs(who:last_connect_time() - time())) + " ago"}', {"Ingame location", $string_utils:nn(who.location)}, {"owned objects", tostr(who.owned_objects:length())}};
who in connected_players() && (info = {@info, {"connected for", $time_utils:english_time(time() - who.last_connect_time)}});
who.custom_profile_info != {} && (info = {@info, @who.custom_profile_info});
for i in (info)
  player:tell($string_utils:capitalize(i[1]) + ": " + i[2]);
endfor
"Last modified Thu Dec  8 11:56:17 2022 UTC by caranov (#133).";
