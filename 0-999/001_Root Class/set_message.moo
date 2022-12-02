#1:set_message   this none this rxd

":set_message(msg_name,new_value)";
"Does the actual dirty work of @<msg_name> object is <new_value>";
"changing the raw value of the message msg_name to be new_value.";
"Both msg_name and new_value should be strings, though their interpretation is up to the object itself.";
" => error value (use E_PROPNF if msg_name isn't recognized)";
" => string error message if something else goes wrong.";
" => 1 (true non-string) if the message is successfully set";
" => 0 (false non-error) if the message is successfully `cleared'";
if (!(caller == this || $perm_utils:controls(caller_perms(), this)))
  return E_PERM;
else
  return `this.(args[1] + "_msg") = args[2] ! ANY' && 1;
endif
