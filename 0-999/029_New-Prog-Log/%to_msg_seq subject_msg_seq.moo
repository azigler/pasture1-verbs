#29:"%to_msg_seq subject_msg_seq"   this none this rxd

":%to_msg_seq/subject_msg_seq(string or list of strings[,mask])";
" => msg_seq of messages containing one of strings in the to line";
if (!this:ok(caller, caller_perms()))
  return E_PERM;
endif
{nlist, ?mask = {1}} = args;
if (typeof(nlist) != LIST)
  nlist = {nlist};
endif
i = 1;
fseq = {};
for msg in (this.messages)
  if (!mask || i < mask[1])
  elseif (length(mask) < 2 || i < mask[2])
    if (msg[2][4] in nlist)
      fseq = $seq_utils:add(fseq, i, i);
    endif
  else
    mask = mask[3..$];
  endif
  i = i + 1;
  $command_utils:suspend_if_needed(0);
endfor
return fseq || "%f %<has> no messages about @programmer'ing " + $string_utils:english_list(nlist, "no one", " or ");
