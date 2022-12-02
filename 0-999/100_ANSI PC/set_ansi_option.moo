#100:set_ansi_option   this none this rxd

":set_ansi_option(oname,value)";
"Changes the value of the named option.";
"Returns a string error if something goes wrong.";
if (!(caller == this || $perm_utils:controls(caller_perms(), this)))
  return tostr(E_PERM);
endif
foo_options = "ansi_options";
"...";
if (typeof(s = $options["ansi"]:set(this.(foo_options), @args)) == STR)
  return s;
elseif (s == this.(foo_options))
  return 0;
else
  this.(foo_options) = s;
  $ansi_utils:update_player_codes(this);
  return 1;
endif
