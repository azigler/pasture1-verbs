#6:get_all_followers   this none this rxd

ret = prevlist = {};
stoploop = 0;
followers = this.followers;
while (true)
  if (stoploop > 20)
    break;
  endif
  mergeret = {};
  prevlist = ret;
  for i in (followers)
    valid(i) && i in ret == 0 && (ret = ret:add(i));
    for ii in (i.followers)
      valid(ii) && ii in ret == 0 && (mergeret = mergeret:add(ii));
    endfor
  endfor
  followers = mergeret;
  if (ret == prevlist)
    break;
  endif
  stoploop = stoploop + 1;
endwhile
return ret;
