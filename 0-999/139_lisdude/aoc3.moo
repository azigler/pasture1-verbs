#139:aoc3   none none none rxd

"https://adventofcode.com/2022/day/3";
tot = 0;
badge_tot = 0;
priority = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
for x, count in (this.aoc3)
  yin();
  if (!(count % 3))
    "Oh geeze. Part two wants to find the badge the last three have in common.";
    {a, b, c} = this.aoc3[count - 2..count];
    for y in [1..length(a)]
      if (index(b, a[y], 1) && index(c, a[y], 1))
        badge_tot = badge_tot + index(priority, a[y], 1);
        break y;
      endif
    endfor
  endif
  split = length(x) / 2;
  {first, second} = {x[1..split], x[split + 1..$]};
  for y in [1..length(first)]
    if (index(second, first[y], 1))
      tot = tot + index(priority, first[y], 1);
      continue x;
    endif
  endfor
endfor
player:tell("Priorities sum: ", tot);
player:tell("Badge sum: ", badge_tot);
