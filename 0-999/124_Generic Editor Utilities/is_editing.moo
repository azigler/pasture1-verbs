#124:is_editing   this none this xd

{player} = args;
return `$code_utils:task_valid(this.last_edits[player in $list_utils:slice(this.last_edits)][2]) ! ANY => 0';
