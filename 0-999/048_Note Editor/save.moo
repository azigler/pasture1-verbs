#48:save   any none none rd

if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
  return;
endif
if (!dobjstr)
  note = this.objects[who];
elseif (1 == (note = this:note_match_failed(dobjstr)))
  return;
else
  this.objects[who] = note;
endif
text = this:text(who);
strmode = length(text) <= 1 && this.strmode[who];
if (strmode)
  text = text ? text[1] | "";
endif
if (ERR == typeof(result = this:set_note_text(note, text)))
  player:tell("Text not saved to ", this:working_on(who), ":  ", result);
  if (result == E_TYPE && typeof(note) == OBJ)
    player:tell("Do `mode list' and try saving again.");
  elseif (!dobjstr)
    player:tell("Use `save' with an argument to save the text elsewhere.");
  endif
else
  player:tell("Text written to ", this:working_on(who), strmode ? " as a single string." | ".");
  this:set_changed(who, 0);
endif
