#47:no_littering_msg   this none this rxd

"recall that this only gets called if :retain_session_on_exit returns true";
return this:ok(who = player in this.active) && !this:changed(who) ? {"Your message is in transit."} | this.(verb);
