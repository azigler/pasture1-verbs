#124:refresh_last_edits   this none this xd

edits = this.last_edits;
"Clear out invalid editor sessions.";
for x in (edits)
  if (!$code_utils:task_valid(x[2]) || !x[1]:is_listening())
    edits = setremove(edits, x);
  endif
endfor
this.last_edits = edits;
