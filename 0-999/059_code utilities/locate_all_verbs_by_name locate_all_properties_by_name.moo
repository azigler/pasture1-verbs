#59:"locate_all_verbs_by_name locate_all_properties_by_name"   this none this rxd

set_task_perms(caller_perms());
{search, ?author = 0} = args;
result = partresult = {};
CU = $command_utils;
type = verb == "locate_all_properties_by_name" ? "prop" | "verb";
ret = {{}, {}};
"      result, partial result";
for x in [#0..max_object()]
  if (!valid(x))
    continue;
  endif
  yin(0, 1000);
  for z in (type == "prop" ? properties(x) | verbs(x))
    if (author != 0)
      if ((type == "verb" ? verb_info(x, (sind = index(z, " ")) ? z[1..sind - 1] | z) | property_info(x, z))[1] != author)
        continue;
      endif
    endif
    if (z == search)
      ret[1] = {@ret[1], {x, search}};
    elseif (index(z, search))
      ret[2] = {@ret[2], {x, z}};
    endif
    yin(0, 1000);
  endfor
endfor
return ret;
