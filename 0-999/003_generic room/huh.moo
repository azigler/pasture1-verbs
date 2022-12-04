#3:huh   this none this rxd

{command, args} = args;
if (valid(exit = this:match_exit(command)))
  exit:invoke(player);
  return 1;
else
  return 0;
endif
"Last modified Sat Dec  3 17:15:21 2022 UTC by caranov (#133).";
