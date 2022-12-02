#155:do_delete_note   this none this rxd

":do_delete_note(INT <note ID>)";
"The end all be all verb for deleting a note after presenting the player with a menu.";
{note} = args;
title = this:get_note_title(note);
if ($command_utils:yes_or_no(tostr("Are you SURE you want to delete the note titled \"", title, "\"?")) == 1)
  " $admin_utils:announce(tostr(player:nn(), \" deleted the note: \", this:category_breadcrumb(this:category_for(note)[1], 1), \" -> \", title, \" {[red]\", note, \"[normal]}\"), \"announce_notes\");";
  this:delete_note(note);
  player:tell("Note deleted.");
else
  player:tell("Aborted.");
endif
