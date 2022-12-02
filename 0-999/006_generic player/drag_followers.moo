#6:drag_followers   this none this rxd

{?silent = 0, ?loc = this.location} = args;
for follower in (this:get_all_followers())
  prevloc = follower.location;
  follower:moveto(this.location);
  if (prevloc != follower.location && silent != 1)
    prevloc:announce_all($string_utils:pronoun_sub(follower.ofollow_out_msg, follower, this));
    follower.location:announce_all_but({follower}, $string_utils:pronoun_sub(follower.ofollow_in_msg, follower, this));
  endif
endfor
