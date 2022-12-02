#55:sort_alist_suspended   this none this rxd

"sort_alist_suspended(interval,alist[,n]) sorts a list of tuples by n-th element.  n defaults to 1.  Calls suspend(interval) as necessary.";
set_task_perms(caller_perms());
"... so it can be killed...";
{interval, alist, ?sort_on = 1} = args;
if ((alist_length = length(alist)) < 10)
  "insertion sort on short lists";
  $command_utils:suspend_if_needed(interval);
  return this:sort(alist, this:slice(@listdelete(args, 1)));
endif
"variables specially expanded for the anal-retentive";
left_index = alist_length / 2;
right_index = (alist_length + 1) / 2;
left_sublist = this:sort_alist_suspended(interval, alist[1..left_index], sort_on);
right_sublist = this:sort_alist_suspended(interval, alist[left_index + 1..alist_length], sort_on);
left_element = left_sublist[left_index];
right_element = right_sublist[right_index];
merged_list = {};
while (1)
  $command_utils:suspend_if_needed(interval);
  if (left_element[sort_on] > right_element[sort_on])
    merged_list = {left_element, @merged_list};
    if (left_index = left_index - 1)
      left_element = left_sublist[left_index];
    else
      return {@right_sublist[1..right_index], @merged_list};
    endif
  else
    merged_list = {right_element, @merged_list};
    if (right_index = right_index - 1)
      right_element = right_sublist[right_index];
    else
      return {@left_sublist[1..left_index], @merged_list};
    endif
  endif
endwhile
