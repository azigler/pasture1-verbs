#4:@kids   any none none rxd

"'@kids <obj>' - List the children of an object. This is handy for seeing whether anybody's actually using your carefully-wrought public objects.";
thing = player:my_match_object(dobjstr);
if (!$command_utils:object_match_failed(thing, dobjstr))
  kids = children(thing);
  if (kids)
    player:notify(tostr(thing:title(), "(", thing, ") has ", length(kids), " kid", length(kids) == 1 ? "" | "s", "."));
    player:notify(tostr($string_utils:names_of(kids)));
  else
    player:notify(tostr(thing:title(), "(", thing, ") has no kids."));
  endif
endif
