#59:task_owner   this none this rxd

":task_owner(INT task_id) => returns the owner of the task belonging to the id.";
if (a = $list_utils:assoc(args[1], queued_tasks()))
  return a[5];
else
  return E_INVARG;
endif
