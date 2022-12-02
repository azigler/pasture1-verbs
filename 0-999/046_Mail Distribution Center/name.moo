#46:name   this none this rxd

what = args[1];
if (!valid(what))
  name = "???";
elseif (!is_player(what) && $object_utils:has_callable_verb(what, "mail_name"))
  name = what:mail_name();
else
  name = what.name;
endif
while (m = match(name, "(#[0-9]+)"))
  {s, e} = m[1..2];
  name[s..e] = "";
endwhile
return tostr(name, " (", what, ")");
