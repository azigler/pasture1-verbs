#145:read   this none this rxd

{?to = 5} = args;
if (to > length(mapkeys(this.entries)))
  to = this:entries_to();
endif
ret = {};
for i in (mapkeys($changelog.entries):reverse()[1..to])
  ret = {@ret, @{i + ":", @$changelog.entries[i]}};
endfor
return ret;
"Last modified Mon Dec  5 18:51:42 2022 UTC by caranov (#133).";
