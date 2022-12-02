#68:get   this none this rxd

":get(options,name) => returns the value of the option specified by name";
"i.e., if {name,value} is present in options, return value";
"      if name is present, return 1";
"      otherwise return 0";
{options, name} = args;
if (name in options)
  return 1;
elseif (a = $list_utils:assoc(name, options))
  return a[2];
else
  return 0;
endif
