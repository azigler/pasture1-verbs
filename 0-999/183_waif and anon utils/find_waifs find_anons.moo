#183:"find_waifs find_anons"   this none this rxd

"Provides a summary of all properties and running verb programs that contain instantiated waifs or anonymous objects.";
"";
"Usage: ;$waif_utils:find_waifs()";
"       ;$waif_utils:find_anons()";
if (!player.wizard)
  return E_PERM;
endif
total = class = tasks = 0;
exclude = {$spell};
find_anon = index(verb, "anon");
search_verb = tostr("find_", find_anon ? "anon" | "waif", "_types");
{min, max} = {#0, max_object()};
" -- Constants (avoid #0 property lookups on each iteration of loops) -- ";
WAIF_UTILS = $waif_utils;
STRING_UTILS = $string_utils;
OBJECT_UTILS = $object_utils;
LIST_UTILS = $list_utils;
" -- ";
player:tell("Searching for ", find_anon ? "ANON" | "WAIF", " instances. This may take some time...");
start = ftime(1);
for x in [min..max]
  yin(0, 1000);
  if (!valid(x))
    continue;
  endif
  if (toint(x) % 100 == 0 && player:is_listening() == 0)
    "No point in carrying on if the player isn't even listening.";
    return;
  elseif (x in exclude)
    continue;
  endif
  for y in (OBJECT_UTILS:all_properties(x))
    yin(0, 1000);
    if (is_clear_property(x, y))
      continue y;
    endif
    match = WAIF_UTILS:(search_verb)(x.(y), class);
    if (match != {})
      total = total + 1;
      player:tell(STRING_UTILS:nn(x), "[bold][yellow].[normal](", y, ")");
      for z in (match)
        yin(0, 1000);
        player:tell("    ", `STRING_UTILS:nn(find_anon ? parent(z) | z.class) ! E_INVARG => "*INVALID*"');
      endfor
    endif
  endfor
endfor
"Search for running verb programs containing waifs / anons. But only do this when a specific object wasn't specified.";
if (min == #0 && max == max_object())
  for x in (queued_tasks(1))
    if (length(x) < 11 || x[11] == {})
      continue;
    endif
    match = WAIF_UTILS:(search_verb)(x[11], class);
    if (match != {})
      tasks = tasks + 1;
      player:tell(x[6], ":", x[7], " (task ID ", x[1], ")");
      for z in (match)
        yin(0, 1000);
        player:tell("    ", find_anon ? parent(z) | STRING_UTILS:nn(z.class));
      endfor
    endif
  endfor
endif
player:tell();
player:tell("Total: ", total, " ", total == 1 ? "property" | "properties", tasks > 0 ? tostr(" and ", tasks, " ", tasks == 1 ? "task" | "tasks") | "", " in ", ftime(1) - start, " seconds.");
"Last modified Tue Dec  6 22:30:17 2022 UTC by Zig (#2).";
