#58:set_prog_option   this none this rxd

":set_prog_option(oname,value)";
"Changes the value of the named option.";
"Returns a string error if something goes wrong.";
if (!(caller == this || $perm_utils:controls(caller_perms(), this)))
  return tostr(E_PERM);
endif
"...this is kludgy, but it saves me from writing the same verb 3 times.";
"...there's got to be a better way to do this...";
verb[1..4] = "";
foo_options = verb + "s";
prop = verb[1..index(verb, "_") - 1];
"...";
if (typeof(s = $options[prop]:set(this.(foo_options), @args)) == STR)
  return s;
elseif (s == this.(foo_options))
  return 0;
else
  this.(foo_options) = s;
  return 1;
endif
