#24:"all_wizards_advertised all_wizards all_wizards_unadvertised"   this none this rxd

":all_wizards_advertised() => list of all wizards who have set .advertised true and players mentioned their .public_identity properties as being wizard counterparts";
wizzes = $object_utils:leaves($wiz);
wlist = {};
everyone = verb == "all_wizards_unadvertised";
for w in (wizzes)
  if (w.wizard && (w.advertised || everyone))
    if (is_player(w))
      wlist = setadd(wlist, w);
    endif
    if (`is_player(w.public_identity) ! ANY')
      wlist = setadd(wlist, w.public_identity);
    endif
  endif
endfor
return wlist;
