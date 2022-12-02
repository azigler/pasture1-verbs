#3:get_all_followers   this none this rxd

{who} = args;
ret = who.followers;
stoploop = 0;
while (true)
  if (stoploop > 20)
    break;
  endif
  mergeret = {};
  for i in (ret)
    i in ret == 0 && (ret = ret:setadd(i));
    for ii in (i.followers)
      ii in ret == 0 && (mergeret = mergeret:setadd(ii));
    endfor
  endfor
  ret = {@ret, mergeret};
  stoploop = stoploop + 1;
endwhile
return ret;
