#19:dump_topic   this none this rxd

if (E_PROPNF != (text = pass(@args)) || (args[1][1] != "$" || (!((uprop = args[1][2..$]) in properties(#0)) || typeof(uobj = #0.(uprop)) != OBJ)))
  return text;
else
  udesc = uobj.description;
  return {tostr(";;$", uprop, ".description = $command_utils:read_lines()"), @$command_utils:dump_lines(typeof(udesc) == LIST ? udesc | {udesc})};
endif
