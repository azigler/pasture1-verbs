#6:disband   none none none rxd

if (!this.followers)
  return player:tell("You do not have any followers.");
endif
for i in (this.followers)
  i.following = 0;
  i:tell("(You are no longer following anyone.)");
endfor
this.followers = {};
this.location:announce_all($string_utils:pronoun_sub("%N has disbanded %P group."));
