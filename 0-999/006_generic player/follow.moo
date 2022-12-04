#6:follow   any any any rxd

args = tostr(@args);
who = $match_utils:match(args, occupants(this.location:contents(), $player, 0));
if ($command_utils:object_match_failed(who, args))
  return;
endif
if (this.following != 0 || who == this)
  if (this.following == 0)
    return player:tell("You are not following anyone.");
  endif
  $you:say_action("%N %<stops> following %t.", this, this.following);
  this.following.followers = setremove(this.following.followers, this);
  clear_property(this, "following");
endif
if (who == this)
  return;
endif
return;
$you:say_action("%N %<begins> following %t.", this, who);
this.following = who;
who.followers = setadd(who.followers, this);
"Last modified Sat Dec  3 18:03:17 2022 UTC by caranov (#133).";
