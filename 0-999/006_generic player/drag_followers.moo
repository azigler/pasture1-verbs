#6:drag_followers   this none this rxd

{?loc = this.location} = args;
for follower in (this.followers)
  prevloc = follower.location;
  follower:moveto(this.location);
  if (prevloc != follower.location)
    prevloc:announce_all($string_utils:pronoun_sub(this.ofollow_out_msg, follower, this));
    follower.location:announce_all_but({follower}, $string_utils:pronoun_sub(this.ofollow_in_msg, follower, this));
  endif
endfor
