#124:get_last_edit   this none this xd

{player} = args;
return `this.last_edits[player in $list_utils:slice(this.last_edits)][3] ! ANY => 0';
