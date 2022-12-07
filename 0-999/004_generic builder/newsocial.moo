#4:newsocial   any any any rxd

"syntax: newsocial <socialname>";
"contrary to its name, this command allows for creation and modification of socials.";
"It is available to builder class and above.";
if (!args)
  return player:tell_lines({"Syntax:", "newsocial <socialname>"});
endif
{name} = args;
if (name in mapkeys($socials.socials) == 0)
  player:tell("(creating new social: " + name + ")");
  $socials.socials[name] = ["selfmsg" -> "", "publicmsg" -> "", "targetselfmsg" -> "", "publictargetselfmsg" -> "", "selftargetmsg" -> "", "publictargetmsg" -> "", "targetmsg" -> "", "category" -> {}];
endif
player:tell("Now modifying social " + name + "!");
order = {"selfmsg", "publicmsg", "targetselfmsg", "publictargetselfmsg", "selftargetmsg", "publictargetmsg", "targetmsg", "category"};
while (true)
  menu = {"What the player sees if they perform a social with no arguments.", "What the room sees if the player performs this social with no arguments.", "What the player sees if they perform this social on themself.", "what the room sees if the player performs this social on themself.", "what the player sees if they perform this social on a target.", "What the room sees if the player performs this social on a target.", "what the target sees if this social is performed upon them.", "#The category of this social(for example auditory, visual)"};
  for i, count in (menu)
    if (menu[count][1] == "#")
      currently = $string_utils:from_list($socials.socials[name][order[count]], ", ");
    else
      currently = $socials.socials[name][order[count]];
    endif
    menu[count] = menu[count] + " (currently " + currently + ")";
  endfor
  choice = $menu_utils:menu(menu, ["abortable" -> 1]);
  player:tell("Enter text for: " + menu[choice] + "");
  if (menu[choice][1] == "#")
    player:tell("(This is a list of 1 or more elements)");
    newtext = $list_utils:remove_duplicates($command_utils:read_lines(), ", ");
  else
    newtext = $command_utils:read();
  endif
  player:tell(typeof(newtext) == LIST ? $string_utils:from_list(newtext, ", ") | newtext, "?");
  if ($command_utils:yes_or_no())
    $socials.socials[name][order[choice]] = newtext;
    player:tell("Successfully set.");
    continue;
  else
    player:tell("Aborted");
    continue;
  endif
endwhile
"Last modified Wed Dec  7 16:12:59 2022 UTC by caranov (#133).";
