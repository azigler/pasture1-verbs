#33:from_sorted_list   this none this rxd

":from_sorted_list(sorted_list) => corresponding sequence.";
if (!(lst = args[1]))
  return {};
else
  seq = {i = lst[1]};
  next = i + 1;
  for i in (listdelete(lst, 1))
    if (i != next)
      seq = {@seq, next, i};
    endif
    next = i + 1;
  endfor
  return next == $minint ? seq | {@seq, next};
endif
