#46:body_msg_seq   this none this rxd

":body_msg_seq(target[,mask]) => msg_seq of messages with target in the body";
set_task_perms(caller_perms());
{target, ?mask = {1}} = args;
i = 1;
seq = {};
for msg in (caller.messages)
  if (!mask || i < mask[1])
  elseif ({@mask, $maxint}[2] <= i)
    mask = mask[3..$];
    "Old code follows. Lets save ticks and munge up the whole message body into one big string and index it. Don't need to know where target is in there, just that it is or isn't there";
  elseif ((bstart = "" in (msg = msg[2])) && length(msg) > bstart && index(tostr(@msg[bstart + 1..$]), target))
    seq = $seq_utils:add(seq, i, i);
    "elseif ((bstart = \"\" in (msg = msg[2])) && (l = length(msg)) > bstart)";
    "while (!index(msg[l], target) && (l = l - 1) > bstart)";
    "$command_utils:suspend_if_needed(0);";
    "endwhile";
    "if (l > bstart)";
    "seq = $seq_utils:add(seq, i, i);";
    "endif";
  endif
  i = i + 1;
  $command_utils:suspend_if_needed(0);
endfor
return seq || tostr("%f %<has> no messages containing `", target, "' in the body.");
