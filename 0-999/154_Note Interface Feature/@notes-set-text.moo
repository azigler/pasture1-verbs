#154:@notes-set-text   any any any rxd

"@notes-set-text <id>";
"Set the text of the note <id>. This command is only intended to be called by the local editor. As such, it does minimal sanity checking.";
note = toint(argstr);
"We want this to be as silent as possible, soooo...";
body = {};
while ((line = read(player)) != ".")
  body = {@body, line};
endwhile
this.utils:set_note_text(note, body);
name = this.utils:note_name(note);
player:tell("Set text of note \"", name, "\".");
