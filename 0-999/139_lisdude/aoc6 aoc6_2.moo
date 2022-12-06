#139:"aoc6 aoc6_2"   none none none rxd

"https://adventofcode.com/2022/day/6";
"aoc6: Part one of the challenge. Find the start-of-packet marker.";
"aoc6_2: Part two of the challenge. Find the start-of-message marker.";
if (verb == "aoc6")
  count = ind = 3;
else
  count = ind = 13;
endif
for x in (this.aoc6[4..$])
  yin();
  count = count + 1;
  "This is probably stupid and costly, but it works.";
  used_letters = {};
  for y in (this.aoc6[count - ind..count])
    if (!(y in used_letters))
      used_letters = {@used_letters, y};
    endif
  endfor
  if (length(used_letters) == ind + 1)
    return player:tell(count);
  endif
endfor
