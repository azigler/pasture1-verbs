#24:"connected_wizards connected_wizards_unadvertised"   this none this rxd

":connected_wizards() => list of currently connected wizards and players mentioned in .public_identity properties as being wizard counterparts.";
wizzes = $object_utils:leaves($wiz);
wlist = {};
everyone = verb == "connected_wizards_unadvertised";
for w in (wizzes)
  if (w.wizard && (w.advertised || everyone))
    if (`connected_seconds(w) ! ANY => 0')
      wlist = setadd(wlist, w);
    endif
    if (`connected_seconds(w.public_identity) ! ANY => 0')
      wlist = setadd(wlist, w.public_identity);
    endif
  endif
endfor
return wlist;
