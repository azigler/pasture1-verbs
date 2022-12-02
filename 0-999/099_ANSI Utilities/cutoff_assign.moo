#99:cutoff_assign   this none this rxd

":cutoff_assign (STR string, NUM start, NUM end, STR replacement[, NUM extra])";
"                                => STR";
"Example:";
"  string[2..3] = \"test\";";
"Is the same as:";
"  string = $ansi_utils:cutoff_assign(string, 2, 3, \"test\");";
"Except that it ignores the ANSI codes in <string> when finding <start> and";
"<end>.  If <extra> is specified and true, any codes after <end> but before";
"the next character will also be overwritten.";
if (typeof(a = this:cutoff_locs(@listdelete(args, 4))) == LIST)
  args[1][a[1]..a[2]] = args[4];
  return args[1];
else
  return a;
endif
