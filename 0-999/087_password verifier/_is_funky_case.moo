#87:_is_funky_case   this none this rxd

pwd = args[1];
if (!strcmp(pwd, u = $string_utils:uppercase(pwd)))
  return 0;
elseif (!strcmp(pwd, l = $string_utils:lowercase(pwd)))
  return 0;
elseif (!strcmp(pwd, tostr(u[1], l[2..$])))
  return 0;
else
  return 1;
endif
