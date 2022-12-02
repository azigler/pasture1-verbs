#31:disfunc   this none this rxd

if (valid(cp = caller_perms()) && caller != this && !$perm_utils:controls(cp, this) && cp != this && caller != #0)
  return E_PERM;
endif
"Don't let another guest use this one until all this is done. See :defer, Ho_Yan 1/19/94";
this.free_to_use = 0;
this:log_disconnect();
this:erase_paranoid_data();
try
  if (this.location != this.home)
    this:room_announce(player.name, " has disconnected.");
    this:room_announce($string_utils:pronoun_sub($housekeeper.take_away_msg, this, $housekeeper));
    move(this, this.home);
    this:room_announce($string_utils:pronoun_sub($housekeeper.drop_off_msg, this, $housekeeper));
  endif
finally
  this:do_reset();
  this.free_to_use = 1;
endtry
