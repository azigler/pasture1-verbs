#57:moveto   this none this rxd

set_task_perms(caller in {this, $generic_editor, $verb_editor, $mail_editor, $note_editor} ? this.owner | caller_perms());
`move(this, args[1]) ! ANY';
