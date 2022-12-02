#20:_cap_property   this none this rxd

"cap_property(what,prop[,ucase]) returns what.(prop) but capitalized if either ucase is true or the prop name specified is capitalized.";
"If prop is blank, returns what:title().";
"If prop is bogus or otherwise irretrievable, returns the error.";
"If capitalization is indicated, we return what.(prop+\"c\") if that exists, else we capitalize what.(prop) in the usual fashion.  There is a special exception for is_player(what)&&prop==\"name\" where we just return what.name if no .namec is provided --- ie., a player's .name is never capitalized in the usual fashion.";
"If args[1] is a list, calls itself on each element of the list and returns $string_utils:english_list(those results).";
{what, prop, ?ucase = 0} = args;
set_task_perms(caller_perms());
if (typeof(what) == LIST)
  result = {};
  for who in (what)
    result = {@result, this:_cap_property(who, prop, ucase)};
  endfor
  return $string_utils:english_list(result);
endif
ucase = prop && strcmp(prop, "a") < 0 || ucase;
if (!prop)
  return valid(what) ? ucase ? what:titlec() | what:title() | (ucase ? "N" | "n") + "othing";
elseif (!ucase || typeof(s = `what.(prop + "c") ! ANY') == ERR)
  if (prop == "name")
    s = valid(what) ? what.name | "nothing";
    ucase = ucase && !is_player(what);
  else
    s = `$object_utils:has_property(what, prop) ? what.(prop) | $player.(prop) ! ANY';
  endif
  if (ucase && (s && (typeof(s) == STR && ((z = index(this.alphabet, s[1], 1)) < 27 && z > 0))))
    s[1] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"[z];
  endif
endif
return typeof(s) == ERR ? s | tostr(s);
