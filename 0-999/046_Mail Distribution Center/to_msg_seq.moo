#46:to_msg_seq   this none this rxd

":to_msg_seq(object or list[,mask]) => msg_seq of messages to those people";
set_task_perms(caller_perms());
{plist, ?mask = {1}} = args;
if (typeof(plist) != LIST)
  plist = {plist};
endif
i = 1;
seq = {};
for msg in (caller.messages)
  if (!mask || i < mask[1])
  elseif (length(mask) < 2 || i < mask[2])
    toline = msg[2][3];
    for r in ($mail_agent:parse_address_field(toline))
      if (r in plist)
        seq = $seq_utils:add(seq, i, i);
      endif
    endfor
  else
    mask = mask[3..$];
  endif
  i = i + 1;
  $command_utils:suspend_if_needed(0);
endfor
return seq || "%f %<has> no messages to " + $string_utils:english_list($list_utils:map_arg(2, $string_utils, "pronoun_sub", "%n (%#)", plist), "no one", " or ");
