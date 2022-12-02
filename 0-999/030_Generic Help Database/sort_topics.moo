#30:sort_topics   this none this rxd

":sort_topics(list_of_topics) -- sorts the given list of strings, assuming that they're help-system topic names";
buckets = "abcdefghijklmnopqrstuvwxyz";
keys = names = $list_utils:make(length(buckets) + 1, {});
for name in (setremove(args[1], ""))
  key = index(".@", name[1]) ? name[2..$] + " " | name;
  k = index(buckets, key[1]) + 1;
  bucket = keys[k];
  i = $list_utils:find_insert(bucket, key);
  keys[k] = listinsert(bucket, key, i);
  names[k] = listinsert(names[k], name, i);
  $command_utils:suspend_if_needed(0);
endfor
return $list_utils:append(@names);
