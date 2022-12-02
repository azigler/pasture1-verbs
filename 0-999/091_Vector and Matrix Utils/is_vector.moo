#91:is_vector   this none this rxd

"A vector shall be defined as a list of INTs or FLOATs. (I'm not gonna worry about them all being the same type.)";
flag = 1;
{v} = args;
if (typeof(v) != LIST)
  return 0;
endif
for n in (v)
  if ((ntype = typeof(n)) != INT && ntype != FLOAT)
    flag = 0;
    break;
  endif
  $command_utils:suspend_if_needed(0);
endfor
return flag;
