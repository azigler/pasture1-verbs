#113:edit_set_note_value   this none this rxd

set_task_perms(caller_perms());
{reference, type, content} = args;
"reference format == [str|val]:#xx[.pname]";
if (!match(reference, "^%(str%|val%):.+"))
  return {"Malformed reference: " + reference};
else
  vtype = reference[1..3];
  reference = reference[5..$];
  if (vtype == "str" && type == "string" && length(content) <= 1)
    text = content ? content[1] | "";
  elseif (vtype == "val")
    text = {};
    for x in [1..length(content)]
      $sin(0);
      value = $string_utils:to_value(content[x]);
      if (value[1] != 1)
        return {tostr("Error on line ", x, ":  ", value[2]), "Value not saved."};
      else
        text = {@text, value[2]};
      endif
    endfor
  else
    text = content;
  endif
endif
if (spec = $code_utils:parse_propref(reference))
  o = $code_utils:toobj(spec[1]);
  p = spec[2];
  if (typeof(o) == OBJ)
    if ($object_utils:has_callable_verb(o, setter = "set_" + p))
      e = o:(setter)(text);
    else
      e = o.(p) = text;
    endif
  else
    return {"Malformed reference: You must supply an object number."};
  endif
  if (typeof(e) == ERR)
    raise(e, tostr("Error: ", e));
  else
    return tostr("Set ", p, " property of ", o.name, " (", o, ").");
  endif
elseif (typeof(note = $code_utils:toobj(argstr)) == OBJ)
  o = note;
  e = note:set_text(text);
  if (typeof(e) == ERR)
    return {tostr("Error: ", e)};
  else
    return tostr("Set text of ", o.name, ".");
  endif
else
  raise(E_INVARG, tostr("Error: Malformed argument to ", verb, ": ", argstr));
endif
