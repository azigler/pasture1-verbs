#58:eval_value_to_string   this none this rxd

set_task_perms(caller_perms());
if (typeof(val = args[1]) == OBJ)
  return tostr("=> ", val, "  ", valid(val) ? "(" + val.name + ")" | ((a = $list_utils:assoc(val, {{#-1, "<$nothing>"}, {#-2, "<$ambiguous_match>"}, {#-3, "<$failed_match>"}})) ? a[2] | "<invalid>"));
elseif (typeof(val) == ERR)
  return tostr("=> ", toliteral(val), "  (", val, ")");
else
  return tostr("=> ", toliteral(val));
endif
