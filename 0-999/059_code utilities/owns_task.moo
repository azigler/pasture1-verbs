#59:owns_task   this none this rxd

"$code_utils:owns_task(task_id, who)";
"The purpose of this is to be faster than $code_utils:task_owner(task_id) in those cases where you are interested in whether a certain person owns the task rather than in determining the owner of a task where you have no preconceived notion of the owner.";
return $list_utils:assoc(args[1], $wiz_utils:queued_tasks(args[2]));
