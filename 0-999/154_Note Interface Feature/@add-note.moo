#154:@add-note   any any any rxd

"The interface for adding a note.";
"The user is presented with a category list. When they select the category, they either pick a name or their arguments are used as the name. They then get dumped into the standard :add_note verb.";
categories = this.utils:print_category_tree(1, args);
choice = this.utils:standard_menu(categories, argstr);
if (choice == $failed_match)
  return player:tell("Invalid selection.");
else
  category = choice[2..$];
  player:tell("Note title:");
  title = $command_utils:read();
  player:tell("Enter tags, one per line. You can configure tag color with the [red]@tags[normal] command. Known tags:");
  player:tell(this.utils:tag_title_list(this.utils:all_tags()));
  tags = $edit_utils:editor();
  new_note = this.utils:add_note(title, {});
  this.utils:add_note_to_category(new_note, category);
  for x in (tags)
    if (x == "")
      continue;
    endif
    tag_id = this.utils:add_tag(x);
    this.utils:add_tag_to_note(tag_id, new_note);
  endfor
  player:tell("Note body:");
  upload_command = tostr("@notes-set-text ", new_note);
  body = this.utils:invoke_editor(upload_command, {}, title);
endif
