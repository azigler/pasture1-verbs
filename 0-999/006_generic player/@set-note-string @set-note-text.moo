#6:"@set-note-string @set-note-text"   any none none rd

"Usage:  @set-note-{string | text} {#xx | #xx.pname}";
"        ...lines of text...";
"        .";
"";
"For use by clients' local editors, to save new text for a note or object property.  See $note_editor:local_editing_info() for details.";
text = $command_utils:read_lines_escape((active = player in $note_editor.active) ? {} | {"@edit"}, {tostr("Changing ", argstr, "."), @active ? {} | {"Type `@edit' to take this into the note editor."}});
if (text && text[1] == "@edit")
  $note_editor:invoke(argstr, verb);
  who = $note_editor:loaded(player);
  if (who)
    $note_editor.texts[who] = text[2];
  endif
  return;
endif
set_task_perms(player);
text = text[2];
if (verb == "@set-note-string" && length(text) <= 1)
  text = text ? text[1] | "";
endif
if (spec = $code_utils:parse_propref(argstr))
  o = player:my_match_object(spec[1]);
  p = spec[2];
  if ($object_utils:has_verb(o, vb = "set_" + p) && typeof(e = o:(vb)(text)) != ERR)
    player:tell("Set ", p, " property of ", o.name, " (", o, ") via :", vb, ".");
  else
    original = text;
    for x in [1..length(text)]
      $sin(0);
      value = $string_utils:to_value(text[x]);
      if (value[1] != 1)
        player:tell("Error:  ", value[2]);
        player:tell("... assuming data is all text.");
        text = original;
        break;
      else
        text[x] = value[2];
      endif
    endfor
    if (text != (e = `o.(p) = text ! ANY'))
      player:tell("Error:  ", e);
    else
      player:tell("Set ", p, " property of ", o.name, " (", o, ").");
    endif
  endif
elseif (typeof(note = $code_utils:toobj(argstr)) == OBJ)
  e = note:set_text(text);
  if (typeof(e) == ERR)
    player:tell("Error:  ", e);
  else
    player:tell("Set text of ", note.name, " (", note, ").");
  endif
else
  player:tell("Error:  Malformed argument to ", verb, ": ", argstr);
endif
