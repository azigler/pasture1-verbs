#14:from_msg_seq   this none this rxd

":from_msg_seq(object or list)";
" => msg_seq of messages from any of these senders";
if (!this:ok(caller, caller_perms()))
  return E_PERM;
elseif (!this.messages)
  return {};
endif
{plist, ?mask = {1, this.messages[2] + 1}} = args;
if (typeof(plist) != LIST)
  plist = {plist};
endif
fseq = {};
for m in [1..length(mask) / 2]
  handle = this._mgr:start(this.messages, i = mask[2 * m - 1], mask[2 * m] - 1);
  while (handle)
    for msg in (handle[1])
      fromline = msg[4];
      for f in ($mail_agent:parse_address_field(fromline))
        if (f in plist)
          fseq = $seq_utils:add(fseq, i, i);
        endif
      endfor
      i = i + 1;
      $command_utils:suspend_if_needed(0);
    endfor
    handle = this._mgr:next(@listdelete(handle, 1));
  endwhile
endfor
return fseq || "%f %<has> no messages from " + $string_utils:english_list($list_utils:map_arg(2, $string_utils, "pronoun_sub", "%n (%#)", plist), "no one", " or ");
