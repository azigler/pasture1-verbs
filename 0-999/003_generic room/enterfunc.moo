#3:enterfunc   this none this rxd

object = args[1];
if (is_player(object) && object.location == this)
  player = object;
  this:look_self(player.brief);
endif
if (object == this.blessed_object)
  this.blessed_object = #-1;
endif
if (is_player(object) && object.followers)
  followers = object:get_all_followers();
  res = followers:length() > 1 ? 1 | 0;
  object:drag_followers(res);
  fork (0)
    res == 1 && object.location:announce_all($string_utils:title_list(followers) + " follow in behind " + object.name);
  endfork
endif
"Last modified Sat Dec  3 19:52:09 2022 UTC by caranov (#133).";
