#40:"@typo @bug @suggest*ion @idea @comment"   any any any rd

subject = tostr($string_utils:capitalize(verb[2..$]), ":  ", (loc = this.location).name, "(", loc, ")");
if (this != player)
  return E_PERM;
elseif (argstr)
  result = $mail_agent:send_message(this, {loc.owner}, subject, argstr);
  if (result && result[1])
    player:notify(tostr("Your ", verb, " sent to ", $mail_agent:name_list(@listdelete(result, 1)), ".  Input is appreciated, as always."));
  else
    player:notify(tostr("Huh?  This room's owner (", loc.owner, ") is invalid?  Tell a wizard..."));
  endif
  return;
elseif (!($object_utils:isa(loc, $room) && loc.free_entry))
  player:notify_lines({tostr("You need to make it a one-liner, i.e., `", verb, " something or other'."), "This room may not let you back in if you go to the Mail Room."});
elseif ($object_utils:isa(loc, $generic_editor))
  player:notify_lines({tostr("You need to make it a one-liner, i.e., `", verb, " something or other'."), "Sending you to the Mail Room from an editor is usually a bad idea."});
else
  $mail_editor:invoke({tostr(loc.owner)}, verb, subject);
endif
if (verb == "@bug")
  player:notify("For a @bug report, be sure to mention exactly what it was you typed to trigger the error...");
endif
