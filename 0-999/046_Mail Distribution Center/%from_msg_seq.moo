#46:%from_msg_seq   this none this rxd

":%from_msg_seq(string or list of strings[,mask])";
" => msg_seq of messages with one of these strings in the from line";
set_task_perms(caller_perms());
{nlist, ?mask = {1}} = args;
if (typeof(nlist) != LIST)
  nlist = {nlist};
endif
i = 1;
fseq = {};
for msg in (caller.messages)
  if (!mask || i < mask[1])
  elseif (length(mask) < 2 || i < mask[2])
    fromline = " " + msg[2][2];
    for n in (nlist)
      if (index(fromline, n))
        fseq = $seq_utils:add(fseq, i, i);
      endif
    endfor
  else
    mask = mask[3..$];
  endif
  i = i + 1;
  $command_utils:suspend_if_needed(0);
endfor
return fseq || "%f %<has> no messages from " + $string_utils:english_list($list_utils:map_arg($string_utils, "print", nlist), "no one", " or ");
