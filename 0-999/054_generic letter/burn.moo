#54:burn   this none none rd

who = valid(caller_perms()) ? caller_perms() | player;
if ($perm_utils:controls(who, this) || this:is_readable_by(who))
  result = this:do_burn();
else
  result = 0;
endif
player:tell(result ? this:burn_succeeded_msg() | this:burn_failed_msg());
if (msg = result ? this:oburn_succeeded_msg() | this:oburn_failed_msg())
  player.location:announce(player.name, " ", msg);
endif
