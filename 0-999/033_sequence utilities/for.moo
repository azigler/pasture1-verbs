#33:for   this none this rxd

":for([n,]seq,obj,verb,@args) => for s in (seq) obj:verb(s,@args); endfor";
set_task_perms(caller_perms());
if (typeof(n = args[1]) == INT)
  args = listdelete(args, 1);
else
  n = 1;
endif
{seq, object, vname, @args} = args;
if (seq[1] == $minint)
  return E_RANGE;
endif
for r in [1..length(seq) / 2]
  for i in [seq[2 * r - 1]..seq[2 * r] - 1]
    if (typeof(object:(vname)(@listinsert(args, i, n))) == ERR)
      return;
    endif
  endfor
endfor
if (length(seq) % 2)
  i = seq[$];
  while (1)
    if (typeof(object:(vname)(@listinsert(args, i, n))) == ERR)
      return;
    endif
    i = i + 1;
  endwhile
endif
