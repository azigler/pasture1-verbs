#3:enterfunc   this none this rxd

object = args[1];
if (is_player(object) && object.location == this)
  player = object;
  this:look_self(player.brief);
endif
if (object == this.blessed_object)
  this.blessed_object = #-1;
endif
if (is_player(object))
  followers = player:get_all_followers(object);
  res = length(followers) > 1 && 1;
  object:drag_followers(res);
  res == 1 && this:announce_all($string_utils:title_list(followers) + " follow in behind " + player.name);
endif
