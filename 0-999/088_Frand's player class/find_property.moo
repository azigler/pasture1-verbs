#88:find_property   this none this rxd

"'find_property (<name>)' - Search for a property with the given name. The objects searched are those returned by this:find_properties_on(). The printing order relies on $list_utils:remove_duplicates to leave the *first* copy of each duplicated element in a list; for example, {1, 2, 1} -> {1, 2}, not to {2, 1}.";
name = args[1];
results = "";
objects = $list_utils:remove_duplicates(this:find_properties_on());
for thing in (objects)
  if (valid(thing) && (mom = $object_utils:has_property(thing, name)))
    results = results + "   " + thing.name + "(" + tostr(thing) + ")";
    mom = this:property_inherited_from(thing, name);
    if (thing != mom)
      if (valid(mom))
        results = results + "--" + mom.name + "(" + tostr(mom) + ")";
      else
        results = results + "--built-in";
      endif
    endif
  endif
endfor
if (results)
  this:tell("The property .", name, " is on", results);
else
  this:tell("The property .", name, " is nowhere to be found.");
endif
