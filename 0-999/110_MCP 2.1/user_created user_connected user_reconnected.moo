#110:"user_created user_connected user_reconnected"   this none this rxd

{who} = args;
if (listeners(caller))
  if ($recycler:valid(who.out_of_band_session))
    `who.out_of_band_session:finish() ! ANY';
  endif
  who.out_of_band_session = this:initialize_connection(who);
endif
