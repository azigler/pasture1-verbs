#46:from_msg_seq   this none this rxd

":from_msg_seq(object or list[,mask])";
" => msg_seq of messages from any of these senders";
set_task_perms(caller_perms());
{plist, ?mask = {1}} = args;
if (typeof(plist) != LIST)
  plist = {plist};
endif
i = 1;
fseq = {};
for msg in (caller.messages)
  if (!mask || i < mask[1])
  elseif (length(mask) < 2 || i < mask[2])
    fromline = msg[2][2];
    for f in ($mail_agent:parse_address_field(fromline))
      if (f in plist)
        fseq = $seq_utils:add(fseq, i, i);
      endif
    endfor
  else
    mask = mask[3..$];
  endif
  i = i + 1;
  $command_utils:suspend_if_needed(0);
endfor
return fseq || "%f %<has> no messages from " + $string_utils:english_list($list_utils:map_arg(2, $string_utils, "pronoun_sub", "%n (%#)", plist), "no one", " or ");
