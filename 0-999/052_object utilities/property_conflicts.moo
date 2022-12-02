#52:property_conflicts   this none this rxd

":property_conflicts(object,newparent)";
"Looks for propertyname conflicts that would keep chparent(object,newparent)";
"  from working.";
"Returns a list of elements of the form {<propname>, @<objectlist>}";
"where <objectlist> is list of descendents of object defining <propname>.";
if (!valid(object = args[1]))
  return E_INVARG;
elseif (!valid(newparent = args[2]))
  return newparent == #-1 ? {} | E_INVARG;
elseif (!($perm_utils:controls(caller_perms(), object) && (newparent.f || $perm_utils:controls(caller_perms(), newparent))))
  "... if you couldn't chparent anyway, you don't need to know...";
  return E_PERM;
endif
"... properties existing on newparent";
"... cannot be present on object or any descendent...";
props = conflicts = {};
for o in ({object, @$object_utils:descendents_suspended(object)})
  for p in (properties(o))
    if (`property_info(newparent, p) ! E_PROPNF => 0')
      if (i = p in props)
        conflicts[i] = {@conflicts[i], o};
      else
        props = {@props, p};
        conflicts = {@conflicts, {p, o}};
      endif
    endif
    $command_utils:suspend_if_needed(0);
  endfor
  $command_utils:suspend_if_needed(0);
endfor
return conflicts;
