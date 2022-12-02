#9:"del*ete rem*ove"   any (out of/from inside/from) this rd

if (!this:is_writable_by(player))
  player:tell("You can't modify this note.");
elseif (!dobjstr)
  player:tell("You must tell me which line to delete.");
else
  line = toint(dobjstr);
  if (line < 0)
    line = line + length(this.text) + 1;
  endif
  if (line <= 0 || line > length(this.text))
    player:tell("Line out of range.");
  else
    this:set_text(listdelete(this.text, line));
    player:tell("Line deleted.");
  endif
endif
