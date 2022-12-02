#55:swap_elements   this none this rxd

"swap_elements -- exchange two elements in a list";
"Usage:  $list_utils:swap_elements(<list/LIST>,<index/INT>,<index/INT>)";
"        $list_utils:swap_elements({\"a\",\"b\"},1,2);";
{l, i, j} = args;
if (typeof(l) == LIST && typeof(i) == INT && typeof(j) == INT)
  ll = length(l);
  if (i > 0 && i <= ll && (j > 0 && j <= ll))
    t = l[i];
    l[i] = l[j];
    l[j] = t;
    return l;
  else
    return E_RANGE;
  endif
else
  return E_TYPE;
endif
