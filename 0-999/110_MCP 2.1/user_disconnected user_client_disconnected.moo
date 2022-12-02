#110:"user_disconnected user_client_disconnected"   this none this rxd

{who} = args;
if (listeners(caller))
  if ($recycler:valid(who.out_of_band_session))
    `who.out_of_band_session:finish() ! ANY';
    who.out_of_band_session = $nothing;
  endif
else
  raise(E_PERM);
endif
