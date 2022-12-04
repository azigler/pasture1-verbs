#139:aoc1   none none none rxd

"https://adventofcode.com/2022/day/1";
elves = {};
tot = 0;
for x in (this.aoc1)
  if (x == "")
    elves = {@elves, tot};
    tot = 0;
  else
    tot = tot + toint(x);
  endif
  yin();
endfor
elves = sort(elves, {}, 0, 1);
tot = 0;
for x in [1..3]
  tot = tot + elves[x];
  player:tell("Elf ", x, ": ", elves[x], " calories");
endfor
player:tell("");
player:tell("Grand total: ", tot, " calories");
