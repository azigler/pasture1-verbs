#53:match_object   this none this rxd

"used by $lock_utils to unparse a key expression so one can use `here' and `me' as well as doing the regular object matching.";
token = args[1];
if (token == "me")
  return this.player;
elseif (token == "here")
  if (valid(this.player.location))
    return this.player.location;
  else
    return "'here' has no meaning where " + this.player.name + " is";
  endif
else
  what = this.player.location:match_object(token);
  if (what == $failed_match)
    return "Can't find an object named '" + token + "'";
  elseif (what == $ambiguous_match)
    return "Multiple objects named '" + token + "'";
  else
    return what;
  endif
endif
