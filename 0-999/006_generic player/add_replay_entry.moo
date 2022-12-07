#6:add_replay_entry   this none this rxd

if (this in connected_players() == 0)
  return;
endif
{?categories = {"general"}, ?message = ""} = args;
typeof(categories) == STR && (categories = {categories});
for category in (categories)
  if (!maphaskey(this.replay_history, category))
    this.replay_history[category] = {message};
  endif
  if (this.replay_history[category]:length() >= 100)
    this.replay_history[category] = {};
  endif
  this.replay_history[category] = {@this.replay_history[category], {time(), message}};
endfor
return 1;
"Last modified Wed Dec  7 16:51:12 2022 UTC by caranov (#133).";
