#50:parse_subst   this none this rxd

{cmd, ?recognized_flags = "gcr", ?null_subst_msg = "Null substitution?"} = args;
if (!cmd)
  return "s*ubst/<str1>/<str2>[/[g][c][r][<range>]] expected...";
endif
bchar = cmd[1];
cmd = cmd[2..$];
fromstr = cmd[1..(b2 = index(cmd + bchar, bchar, 1)) - 1];
cmd = cmd[b2 + 1..$];
tostr = cmd[1..(b2 = index(cmd + bchar, bchar, 1)) - 1];
cmd = cmd[b2 + 1..$];
cmdlen = length(cmd);
b2 = 0;
while ((b2 = b2 + 1) <= cmdlen && index(recognized_flags, cmd[b2]))
endwhile
return fromstr == "" && tostr == "" ? null_subst_msg | {fromstr, tostr, cmd[1..b2 - 1], cmd[b2..$]};
