#52:locate_by_name   this none this xd

"$object_utils:locate_by_name(STR search, ?OBJ parent) => Searches the database for objects with <search> in their name and aliases. Returns a list of matches. If <parent> is spessified, this will only return matches that are descendants of that object.";
"Verb created 08/14/2021 by Saeed.";
{search, ?parent = $nothing} = args;
if (parent != $nothing && (!valid(parent) || typeof(parent) != OBJ))
  raise(E_INVARG);
endif
result = locate_by_name(search);
if (result && parent != $nothing)
  result = occupants(result, parent);
  result = result:remove(parent);
endif
return result;
