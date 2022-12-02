#154:@tags   any any any rxd

if (args)
  if (argstr == "")
    return player:tell("Empty strings can't be tags.");
  else
    choice = this.utils:add_tag(argstr);
  endif
else
  tags = this.utils:all_tags();
  if (!tags)
    return player:tell("There are no tags. You can add one by typing: @tag <tag name>");
  else
    tag_menu = {};
    for x in (tags)
      tag_menu = {@tag_menu, this.utils:display_tag(x)};
    endfor
    player:tell("Which tag do you want to modify?");
    choice = tags[$menu_utils:menu(tag_menu)];
  endif
endif
player:tell("Tag: ", this.utils:display_tag(choice));
player:tell("Tag ID: ", choice);
tag_menu = {"Delete Tag", "Change Tag Color"};
opt = tag_menu[$menu_utils:menu(tag_menu)];
if (opt == "Delete Tag")
  if ($command_utils:yes_or_no("Are you sure you want to delete this tag?") == 1)
    this.utils:delete_tag(choice);
    player:tell("Deleted.");
  else
    player:tell("Aborted.");
  endif
elseif (opt == "Change Tag Color")
  name = $ansi_utils:delete(this.utils:display_tag(choice));
  player:tell("Choose a new color:");
  color = $ansi_utils:color_selector();
  if ($command_utils:yes_or_no(tostr("Does this look correct: ", $ansi_utils:hr_to_code(color), name, "[normal]")) == 1)
    player:tell("Color changed.");
    this.utils:add_tag(name, color);
  else
    player:tell("Aborted.");
  endif
endif
