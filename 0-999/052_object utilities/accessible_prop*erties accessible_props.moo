#52:"accessible_prop*erties accessible_props"   this none this rxd

" :accessible_props(object)   => a list of property names (or E_PERM), regardless of the readability of the object.";
thing = args[1];
all = properties(thing);
props = {};
set_task_perms(caller_perms());
for i in (all)
  $command_utils:suspend_if_needed(0);
  if ((info = `property_info(thing, i) ! ANY') != E_PROPNF)
    props = {@props, info ? i | E_PERM};
  endif
endfor
return props;
"Last modified Mon Nov 28 06:19:35 2005 PST, by Roebare (#109000).";
