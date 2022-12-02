#72:adjust_postmaster_for_password   this none this rxd

"adjust_postmaster_for_password(enter_or_exit): permits the MOO to have two different postmasters for different kinds of bounces.  If entering password (argument \"enter\"), change to $network.password_postmaster, else (argument \"exit\") change to $network.usual_postmaster.";
if (args[1] == "enter")
  $network.postmaster = $network.password_postmaster;
  $network.errors_to_address = $network.password_postmaster;
  $network.envelope_from = $network.password_postmaster;
else
  $network.postmaster = $network.usual_postmaster;
  $network.errors_to_address = $network.usual_postmaster;
  $network.envelope_from = $network.blank_envelope ? "" | $network.usual_postmaster;
endif
