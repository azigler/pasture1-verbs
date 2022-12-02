#3:get_all_followers   this none this rxd

{who} = args;
ret = {};
stoploop = 0;
followers = who.followers;
while (true)
  if (stoploop > 20)
    break;
  endif
  mergeret = {};
  for i in (followers)
    i in ret == 0 && (ret = ret:setadd(i));
    for ii in (i.followers)
      ii in ret == 0 && (mergeret = mergeret:setadd(ii));
    endfor
  endfor
  followers = mergeret;
  stoploop = stoploop + 1;
endwhile
return ret;
