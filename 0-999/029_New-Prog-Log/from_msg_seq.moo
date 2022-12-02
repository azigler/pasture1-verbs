#29:from_msg_seq   this none this rxd

":from_msg_seq(object or list[,mask])";
" => msg_seq of messages from any of these senders";
if (!this:ok(caller, caller_perms()))
  return E_PERM;
endif
{plist, ?mask = {1}} = args;
if (typeof(plist) != LIST)
  plist = {plist};
endif
i = 1;
fseq = {};
for msg in (this.messages)
  if (!mask || i < mask[1])
  elseif (length(mask) < 2 || i < mask[2])
    if (msg[2][2] in plist)
      fseq = $seq_utils:add(fseq, i, i);
    endif
  else
    mask = mask[3..$];
  endif
  i = i + 1;
  $command_utils:suspend_if_needed(0);
endfor
return fseq || "%f %<has> no messages from " + $string_utils:english_list($list_utils:map_arg(2, $string_utils, "pronoun_sub", "%n (%#)", plist), "no one", " or ");
