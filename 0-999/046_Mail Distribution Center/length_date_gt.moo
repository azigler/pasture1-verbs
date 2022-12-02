#46:length_date_gt   this none this rxd

set_task_perms(caller_perms());
date = args[1];
msgs = caller.messages;
if ((len = length(caller.messages)) < 25)
  for r in [0..len - 1]
    if (msgs[len - r][2][1] <= date)
      return r;
    endif
  endfor
  return len;
else
  l = 1;
  r = len;
  while (l <= r)
    if (date < msgs[i = (r + l) / 2][2][1])
      r = i - 1;
    else
      l = i + 1;
    endif
  endwhile
  return len - r;
endif
