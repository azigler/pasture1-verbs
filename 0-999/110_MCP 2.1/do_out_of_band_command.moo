#110:do_out_of_band_command   this none this rxd

if (listeners(caller))
  if ($recycler:valid(session = player.out_of_band_session))
    set_task_perms(player);
    return session:do_out_of_band_command(@args);
  endif
endif
