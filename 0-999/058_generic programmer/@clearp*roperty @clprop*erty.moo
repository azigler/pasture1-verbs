#58:"@clearp*roperty @clprop*erty"   any none none rd

"@clearproperty <obj>.<prop>";
"Set the value of <obj>.<prop> to `clear', making it appear to be the same as the property on its parent.";
set_task_perms(player);
if (!(l = $code_utils:parse_propref(dobjstr)))
  player:notify(tostr("Usage:  ", verb, " <object>.<property>"));
elseif ($command_utils:object_match_failed(dobj = player:my_match_object(l[1]), l[1]))
  "... bogus object...";
endif
try
  if (is_clear_property(dobj, prop = l[2]))
    player:notify(tostr("Property ", dobj, ".", prop, " is already clear!"));
    return;
  endif
  clear_property(dobj, prop);
  player:notify(tostr("Property ", dobj, ".", prop, " cleared; value is now ", toliteral(dobj.(prop)), "."));
except (E_INVARG)
  player:notify(tostr("You can't clear ", dobj, ".", prop, "; none of the ancestors define that property."));
except error (ANY)
  player:notify(error[2]);
endtry
