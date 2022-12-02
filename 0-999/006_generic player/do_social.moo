#6:do_social   this none this rxd

"syntax: entity:do_social(social(map), target(obj or string));";
{social, ?target = 0} = args;
if (target && typeof(target) == STR)
  target = $string_utils:match_player(target, this.location);
  if ($command_utils:object_match_failed(target, args[2]))
    return this:tell("You do not see that here.");
  endif
endif
if (target == "")
  this:tell($string_utils:pronoun_sub(social["selfmsg"]));
  this.location:announce($socials:format_social("publicmsg", social["publicmsg"], this));
else
  if (target == player)
    this:tell($socials:format_social("targetself", social["targetselfmsg"], this));
    return this.location:announce($socials:format_social("publictargetself", social["publictargetselfmsg"], this));
  endif
  this:tell($socials:format_social("selftarget", social["selftargetmsg"], target));
  this.location:announce_all_but({this, target}, $socials:format_social("publictarget", social["publictargetmsg"], target));
  return target:tell($socials:format_social("target", social["targetmsg"], target));
endif
