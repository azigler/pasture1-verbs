#46:length_date_le   this none this rxd

set_task_perms(caller_perms());
date = args[1];
msgs = caller.messages;
if ((r = length(caller.messages)) < 25)
  for l in [1..r]
    if (msgs[l][2][1] > date)
      return l - 1;
    endif
  endfor
  return r;
else
  l = 1;
  while (l <= r)
    if (date < msgs[i = (r + l) / 2][2][1])
      r = i - 1;
    else
      l = i + 1;
    endif
  endwhile
  return r;
endif
