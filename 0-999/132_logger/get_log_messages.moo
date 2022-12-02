#132:get_log_messages   this none this xd

":get_log_messages(who, logs[, num-entries[, level]]): Get messages from all matching logs.";
{who, logs, ?entries = 10, ?level = this.default_log_level} = args;
!caller_perms().wizard && raise(E_PERM);
!$object_utils:isa(who, $player) && raise(E_PERM);
if (!logs)
  logs = this:all_logs(who);
elseif (typeof(logs) == STR)
  logs = {logs};
endif
for l in (logs)
  !$object_utils:has_property(this, l + "_log") && raise(E_INVARG);
  !this:is_log_readable_by(who, l) && raise(E_INVARG);
endfor
msgs = {};
for l in (logs)
  log_entries = entries;
  found = 0;
  if (this.(l + "_log")[2])
    if (log_entries > length(this.(l + "_log")[2]))
      log_entries = length(this.(l + "_log")[2]);
    endif
    if (length(logs) == 1 && level == 1)
      msgs = this.(l + "_log")[2][$ - (log_entries - 1)..$];
    else
      m = length(this.(l + "_log")[2]);
      "Check for messages which are at the specified level or higher.";
      while (m >= 1)
        if (this.(l + "_log")[2][m][2] >= level)
          found = found + 1;
          msgs = {length(logs) == 1 ? this.(l + "_log")[2][m] | {l, @this.(l + "_log")[2][m]}, @msgs};
          if (found == log_entries)
            break;
          endif
        endif
        m = m - 1;
      endwhile
    endif
  endif
endfor
if (length(logs) > 1)
  msgs = $list_utils:sort(msgs, $list_utils:slice(msgs, 2));
endif
if (length(msgs) > entries)
  msgs = msgs[$ - (entries - 1)..$];
endif
return msgs;
"Last modified Mon Mar 12 04:41:26 2018 CDT by Jason Perino (#91@ThetaCore).";
