#75:values   this none this xd

{o} = args;
set_task_perms(caller_perms());
r = ["Values" -> {}];
for value in (this:_values(o))
  this:_suspend_if_necessary();
  r["Values"] = {@r["Values"], this:read_value(o, value)};
endfor
return r;
