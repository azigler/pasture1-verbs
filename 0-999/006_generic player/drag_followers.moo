#6:drag_followers   this none this rxd

{?silent = 0, ?multiple = 0} = args;
moved = {};
for follower in (this:get_all_followers())
  prevloc = follower.location;
  follower:moveto(this.location);
  if (prevloc != follower.location && silent != 1)
    prevloc:announce_all($string_utils:pronoun_sub(follower.ofollow_out_msg, follower, this));
    follower.location:announce_all_but({follower}, $string_utils:pronoun_sub(follower.ofollow_in_msg, follower, this));
  endif
  prevloc != follower.location && (moved = moved:Add(follower));
endfor
fork (0)
  multiple == 1 && length(moved) > 1 && this.location:announce_all($string_utils:title_list(moved) + " follow in behind " + this.name);
endfork
"Last modified Mon Dec  5 20:35:56 2022 UTC by caranov (#133).";
