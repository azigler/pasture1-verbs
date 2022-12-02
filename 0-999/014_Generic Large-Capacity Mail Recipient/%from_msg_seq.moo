#14:%from_msg_seq   this none this rxd

":%from_msg_seq(string or list of strings)";
" => msg_seq of messages with one of these strings in the from line";
if (!this:ok(caller, caller_perms()))
  return E_PERM;
elseif (!this.messages)
  return {};
endif
{nlist, ?mask = {1, this.messages[2] + 1}} = args;
if (typeof(nlist) != LIST)
  nlist = {nlist};
endif
fseq = {};
for m in [1..length(mask) / 2]
  handle = this._mgr:start(this.messages, i = mask[2 * m - 1], mask[2 * m] - 1);
  while (handle)
    for msg in (handle[1])
      fromline = " " + msg[4];
      for n in (nlist)
        if (index(fromline, n))
          fseq = $seq_utils:add(fseq, i, i);
        endif
      endfor
      i = i + 1;
      $command_utils:suspend_if_needed(0);
    endfor
    handle = this._mgr:next(@listdelete(handle, 1));
  endwhile
endfor
return fseq || "%f %<has> no messages from " + $string_utils:english_list($list_utils:map_arg($string_utils, "print", nlist), "no one", " or ");
