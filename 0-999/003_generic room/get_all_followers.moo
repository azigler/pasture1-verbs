#3:get_all_followers   this none this rxd

{who} = args;
ret = {};
stoploop = 0;
while (true)
  if (stoploop > 20)
    break;
  endif
  for i in (who.followers)
    i in ret == 0 && (ret = ret:setadd(i));
  endfor
  for ii in (i.followers)
    i in ret == 0 && (ret = ret:setadd(ii));
  endfor
  stoploop = stoploop + 1;
endwhile
return ret;
