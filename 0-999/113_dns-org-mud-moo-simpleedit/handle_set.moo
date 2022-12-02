#113:handle_set   this none this rxd

"Usage:  :handle_set(session, reference, type, content)";
"";
{session, reference, type, content} = args;
if (caller != this)
  raise(E_PERM);
endif
set_task_perms(session.connection);
try
  if (type == "moo-code")
    rval = this:edit_set_program(reference, content);
  elseif (reference == "sendmail")
    rval = this:edit_sendmail(reference, content);
  else
    rval = this:edit_set_note_value(reference, type, content);
  endif
  player:notify_lines(typeof(rval) == LIST ? rval | {rval});
except v (ANY)
  player:notify_lines(typeof(v[2]) == LIST ? v[2] | {v[2]});
  "   player:notify_lines($code_utils:format_traceback(v[4], v[2]));";
endtry
