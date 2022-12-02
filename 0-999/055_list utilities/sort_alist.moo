#55:sort_alist   this none this rxd

":sort_alist(alist[,n]) sorts a list of tuples by n-th (1st) element.";
{alist, ?sort_on = 1} = args;
if ((alist_length = length(alist)) < 25)
  "use insertion sort on short lists";
  return this:sort(alist, this:slice(@args));
endif
left_index = alist_length / 2;
right_index = (alist_length + 1) / 2;
left_sublist = this:sort_alist(alist[1..left_index], sort_on);
right_sublist = this:sort_alist(alist[left_index + 1..alist_length], sort_on);
"...";
"... merge ...";
"...";
left_key = left_sublist[left_index][sort_on];
right_key = right_sublist[right_index][sort_on];
if (left_key > right_key)
  merged_list = {};
else
  "... alist_length >= 25 implies right_index >= 2...";
  "... move right_index downward until left_key > right_key...";
  r = right_index - 1;
  while (left_key <= (right_key = right_sublist[r][sort_on]))
    if (r = r - 1)
    else
      return {@left_sublist, @right_sublist};
    endif
  endwhile
  merged_list = right_sublist[r + 1..right_index];
  right_index = r;
endif
while (l = left_index - 1)
  "... left_key > right_key ...";
  "... move left_index downward until left_key <= right_key...";
  while ((left_key = left_sublist[l][sort_on]) > right_key)
    if (l = l - 1)
    else
      return {@right_sublist[1..right_index], @left_sublist[1..left_index], @merged_list};
    endif
  endwhile
  merged_list[1..0] = left_sublist[l + 1..left_index];
  left_index = l;
  "... left_key <= right_key ...";
  if (r = right_index - 1)
    "... move right_index downward until left_key > right_key...";
    while (left_key <= (right_key = right_sublist[r][sort_on]))
      if (r = r - 1)
      else
        return {@left_sublist[1..left_index], @right_sublist[1..right_index], @merged_list};
      endif
    endwhile
    merged_list[1..0] = right_sublist[r + 1..right_index];
    right_index = r;
  else
    return {@left_sublist[1..left_index], right_sublist[1], @merged_list};
  endif
endwhile
return {@right_sublist[1..right_index], left_sublist[1], @merged_list};
