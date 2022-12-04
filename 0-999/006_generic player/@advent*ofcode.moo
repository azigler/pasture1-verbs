#6:@advent*ofcode   any any any rxd

$advent_2022:fetch();
if ($advent_2022.cache == ([]) || time() - $advent_2022.last_fetch >= 86400)
  return player:tell("Something is wrong. It seems there's been no recent Advent of Code leaderboard data in some time. Sorry!");
else
  ret = scores = {};
  json = $advent_2022.cache;
  player:tell("Advent of Code ", json["event"], " Leaderboard");
  player:tell("");
  for v, k in (json["members"])
    stars = v["stars"];
    score = "[bold][yellow]" + $ansi_utils:space(stars / 2, "*") + "[normal]";
    if (stars % 2)
      score = tostr(score, "[white]*[normal]");
    endif
    score = tostr(score, " (", tofloat(stars) / 2.0, ")");
    ret = {@ret, {v["name"] == "null" ? tostr("anonymous user #", k) | v["name"], tostr(v["local_score"]), score}};
    scores = {@scores, v["local_score"]};
  endfor
endif
ret = sort(ret, scores, 0, 1);
ret = {{"Person", "Total Score", "Stars"}, @ret};
player:tell_lines($string_utils:autofit(ret, 3, 1));
