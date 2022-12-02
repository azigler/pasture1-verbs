#3:get_all_followers   this none this rxd

{who} = args;
ret = {};
stoploop = 0;
followers = who.followers;
prevlist = {};
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
  player:tell(toliteral(followers));
  if (ret == prevlist)
    break;
  endif
  stoploop = stoploop + 1;
endwhile
return ret;
