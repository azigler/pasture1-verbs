#175:has_pole   this none this rxd

{what} = args;
pole = 0;
for i in (what.contents)
  if (parent(i) == #180 && i.owner == what)
    pole = i;
    break;
  endif
endfor
return pole;
"Last modified Tue Dec  6 17:39:31 2022 UTC by caranov (#133).";
