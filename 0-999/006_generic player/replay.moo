#6:replay   any any any rxd

{?category = "general", ?to = 15} = args;
if (toint(category) != 0)
  {to = abs(toint(category)), category = "general"};
endif
{what = category, to = abs(toint(to))};
for i in (mapkeys(this.replay_history))
  if (index(i, category) == 1)
    category = this.replay_history[i];
    what = i;
    break;
  endif
endfor
if (what in mapkeys(this.replay_history) == 0)
  {category = this.replay_history["general"], what = "general"};
endif
player:tell(what + " history:");
if (category:length() <= 0)
  return player:tell("There are no messages.");
endif
to > length(category) && (to = length(category));
for i in (category[$ - to + 1..$])
  player:tell(i[2] + ". " + $time_utils:english_time(abs(time() - i[1])) + " ago.");
endfor
return 1;
"Last modified Thu Dec  8 14:24:51 2022 UTC by caranov (#133).";
