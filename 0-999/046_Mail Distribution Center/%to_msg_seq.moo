#46:%to_msg_seq   this none this rxd

":%to_msg_seq(string or list of strings[,mask])";
" => msg_seq of messages containing one of strings in the to line";
set_task_perms(caller_perms());
{nlist, ?mask = {1}} = args;
if (typeof(nlist) != LIST)
  nlist = {nlist};
endif
i = 1;
seq = {};
for msg in (caller.messages)
  if (!mask || i < mask[1])
  elseif (length(mask) < 2 || i < mask[2])
    toline = " " + msg[2][3];
    for n in (nlist)
      if (index(toline, n))
        seq = $seq_utils:add(seq, i, i);
      endif
    endfor
  else
    mask = mask[3..$];
  endif
  i = i + 1;
  $command_utils:suspend_if_needed(0);
endfor
return seq || "%f %<has> no messages to " + $string_utils:english_list($list_utils:map_arg($string_utils, "print", nlist), "no one", " or ");
