#155:do_edit_note   this none this rxd

":do_dedit_note(INT <note ID>)";
"The end all be all verb for editing a note after presenting the player with a menu.";
{note} = args;
upload_command = tostr("@notes-set-text ", note);
{title, body} = this:get_note(note);
new_body = this:invoke_editor(upload_command, body, title);
