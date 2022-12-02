#30:find_topics   this none this rxd

"WIZARDLY";
if (args)
  "...check for an exact match first...";
  search = args[1];
  if (`$object_utils:has_property(parent(this), search) ! ANY')
    if ($object_utils:has_property(this, " " + search))
      return {search};
    endif
  elseif ($object_utils:has_property(this, search))
    return {search};
  endif
  "...search for partial matches, allowing for";
  "...confusion between topics that do and don't start with @, and";
  ".. confusion between - and _ characters.";
  props = properties(this);
  topics = {};
  if (search[1] == "@")
    search = search[2..$];
  endif
  search = strsub(search, "-", "_");
  if (!search)
    "...don't try searching for partial matches if the string is empty or @";
    "...we'd get *everything*...";
    return {};
  endif
  for prop in (props)
    if ((i = index(strsub(prop, "-", "_"), search)) == 1 || (i == 2 && index(" @", prop[1])))
      topics = {@topics, prop[1] == " " ? prop[2..$] | prop};
    endif
  endfor
  return topics;
else
  "...return list of all topics...";
  props = setremove(properties(this), "");
  for p in (`$object_utils:all_properties(parent(this)) ! ANY => {}')
    if (i = " " + p in props)
      props = {p, @listdelete(props, i)};
    endif
  endfor
  return props;
endif
