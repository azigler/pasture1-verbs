#14:to_msg_seq   this none this rxd

":to_msg_seq(object or list) => msg_seq of messages to those people";
if (!this:ok(caller, caller_perms()))
  return E_PERM;
elseif (!this.messages)
  return {};
endif
{plist, ?mask = {1, this.messages[2] + 1}} = args;
if (typeof(plist) != LIST)
  plist = {plist};
endif
seq = {};
for m in [1..length(mask) / 2]
  handle = this._mgr:start(this.messages, i = mask[2 * m - 1], mask[2 * m] - 1);
  while (handle)
    for msg in (handle[1])
      toline = msg[5];
      for r in ($mail_agent:parse_address_field(toline))
        if (r in plist)
          seq = $seq_utils:add(seq, i, i);
        endif
      endfor
      i = i + 1;
      $command_utils:suspend_if_needed(0);
    endfor
    handle = this._mgr:next(@listdelete(handle, 1));
  endwhile
endfor
return seq || "%f %<has> no messages to " + $string_utils:english_list($list_utils:map_arg(2, $string_utils, "pronoun_sub", "%n (%#)", plist), "no one", " or ");
