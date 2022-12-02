#16:describe_registration   this none this rxd

"Returns a list of strings describing the registration data for an email address.  Args[1] should be the result of this:find.";
set_task_perms(caller_perms());
result = {};
for x in (args[1])
  name = valid(x[1]) && is_player(x[1]) ? x[1].name | "<recycled>";
  email = valid(x[1]) && is_player(x[1]) ? $wiz_utils:get_email_address(x[1]) | "<???>";
  result = {@result, tostr("  ", name, " (", x[1], ") current email: ", email, length(x) > 1 ? " [" + x[2] + "]" | "")};
endfor
return result;
