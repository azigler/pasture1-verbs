#6:replay   any any any rxd

{?category = "general", ?to = 15} = args;
if (toint(category) != 0)
  {to = category, category = "general"};
endif
{what = category, to = toint(to)};
if (what in mapkeys(this.replay_history) == 0)
  category = what = "general";
endif
for i in (mapkeys(this.replay_history))
  if (index(i, category))
    category = this.replay_history[i];
    break;
  endif
endfor
player:tell(what + " history:");
to > length(category) && (to = length(category) - 1);
for i in (category[$ - to + 1..$])
  player:tell(i[2] + ". " + $time_utils:english_time(abs(time() - i[1])) + " ago.");
endfor
return 1;
"Last modified Wed Dec  7 17:12:28 2022 UTC by caranov (#133).";
