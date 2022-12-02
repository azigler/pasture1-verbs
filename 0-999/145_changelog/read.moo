#145:read   this none this rxd

{?to = 5} = args;
if (to >= length(mapkeys(this.entries)))
  to = this:entries_to();
endif
ret = {};
for i in (mapkeys($changelog.entries)[1..to]:reverse())
  ret = {@ret, @{i + ":", @$changelog.entries[i]}};
endfor
return ret;
