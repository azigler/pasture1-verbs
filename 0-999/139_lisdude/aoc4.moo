#139:aoc4   none none none rxd

"https://adventofcode.com/2022/day/4";
total_overlaps = overlaps = 0;
for assignments in (this.aoc4)
  {first, second} = explode(assignments, ",");
  explosions = {@explode(first, "-"), @explode(second, "-")};
  for x in [1..length(explosions)]
    explosions[x] = toint(explosions[x]);
  endfor
  {a, b} = explosions[1..2];
  {y, z} = explosions[3..4];
  if (y >= a && z <= b)
    "Second fully overlaps first";
    total_overlaps = total_overlaps + 1;
  elseif (a >= y && b <= z)
    "First fully overlaps second";
    total_overlaps = total_overlaps + 1;
  elseif (!(b < y || z < a))
    overlaps = overlaps + 1;
  endif
endfor
player:tell(total_overlaps, " total overlaps");
player:tell(overlaps, " individual overlaps");
player:tell(total_overlaps + overlaps, " overlaps in general");
