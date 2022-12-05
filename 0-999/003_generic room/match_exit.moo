#3:match_exit   this none this rxd

{?what = ""} = args;
if (!what)
  return $failed_match;
endif
for i in (this.exits)
  if (valid(i) && valid(i.dest) && what in i.name == 1)
    return i;
  endif
endfor
return $failed_match;
"Last modified Mon Dec  5 17:44:21 2022 UTC by caranov (#133).";
