#4:classes_2   this none this rxd

{root, indent, members, printed} = args;
if (root in members)
  player:tell(indent, root.name, " (", root, ")");
else
  player:tell(indent, "<", root.name, " (", root, ")>");
endif
printed = setremove(printed, root);
indent = indent + "  ";
set_task_perms(caller_perms());
for c in ($list_utils:sort_suspended(2, $set_utils:intersection(children(root), printed)))
  $command_utils:suspend_if_needed(10);
  this:classes_2(c, indent, members, printed);
endfor
