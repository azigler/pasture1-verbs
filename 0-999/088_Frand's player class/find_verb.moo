#88:find_verb   this none this rxd

"'find_verb (<name>)' - Search for a verb with the given name. The objects searched are those returned by this:find_verbs_on(). The printing order relies on $list_utils:remove_duplicates to leave the *first* copy of each duplicated element in a list; for example, {1, 2, 1} -> {1, 2}, not to {2, 1}.";
name = args[1];
results = "";
objects = $list_utils:remove_duplicates(this:find_verbs_on());
for thing in (objects)
  if (valid(thing) && (mom = $object_utils:has_verb(thing, name)))
    results = results + "   " + thing.name + "(" + tostr(thing) + ")";
    mom = mom[1];
    if (thing != mom)
      results = results + "--" + mom.name + "(" + tostr(mom) + ")";
    endif
  endif
endfor
if (results)
  this:tell("The verb :", name, " is on", results);
else
  this:tell("The verb :", name, " is nowhere to be found.");
endif
