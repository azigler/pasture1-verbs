#6:look_self   this none this rxd

player:tell(this:titlec());
pass();
if (!(this in connected_players()))
  player:tell($gender_utils:pronoun_sub("%{:He} %{!is} sleeping.", this));
elseif ((idle = idle_seconds(this)) < 60)
  player:tell($gender_utils:pronoun_sub("%{:He} %{!is} awake and %{!looks} alert.", this));
else
  time = $string_utils:from_seconds(idle);
  player:tell($gender_utils:pronoun_sub("%{:He} %{!is} awake, but %{!has} been staring off into space for ", this), time, ".");
endif
if (c = this:contents())
  this:tell_contents(c);
endif
