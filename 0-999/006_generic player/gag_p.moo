#6:gag_p   this none this rxd

if (player in this.gaglist)
  return 1;
elseif (gag = this.gaglist)
  for x in (callers())
    if (x[1] == #-1 && x[3] == #-1 && x[2] != "")
    elseif (x[1] in gag || x[4] in gag)
      return 1;
    endif
  endfor
endif
return 0;
"--- old definition --";
if (player in this.gaglist)
  return 1;
elseif (this.gaglist)
  for x in (callers())
    if (valid(x[1]))
      if (x[1] in this.gaglist)
        return 1;
      endif
    endif
  endfor
endif
return 0;
