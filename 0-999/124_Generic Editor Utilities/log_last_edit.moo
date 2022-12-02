#124:log_last_edit   this none this xd

{player, task} = args;
this:refresh_last_edits();
if (pos = player in $list_utils:slice(this.last_edits))
  this.last_edits[pos][2] = task;
  this.last_edits[pos][3] = ftime();
else
  this.last_edits = setadd(this.last_edits, {player, task, ftime()});
endif
