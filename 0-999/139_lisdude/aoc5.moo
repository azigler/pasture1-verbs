#139:aoc5   none none none rxd

"https://adventofcode.com/2022/day/5";
abc = "abcdefghijklmnopqrstuvwxyz ";
stacks = $list_utils:make(9, {});
"Break input into stack lists.";
"NOTE: Stack lists are represented top to bottom. e.g. stack[1][1] is the top of stack 1.";
for x, carry_on in (this.aoc5)
  if (x == "" || x[1..2] == " 1")
    carry_on = carry_on + 2;
    break;
  endif
  x = $string_utils:subst(x, {{"[", " "}, {"]", " "}});
  for y in [1..length(x)]
    if (x[y] != " ")
      "Each item in the chart + space (accounting for brackets) is 4 wide.";
      pos = y / 4 + 1;
      stacks[pos] = {@stacks[pos], x[y]};
    endif
  endfor
endfor
"Start moving.";
regex = "move (?<amount>\\d+) from (?<source>\\d+) to (?<dest>\\d+)";
for x in (this.aoc5[carry_on..$])
  match = pcre_match(x, regex)[1];
  {amount, source, dest} = {toint(match["amount"]["match"]), toint(match["source"]["match"]), toint(match["dest"]["match"])};
  if (verb == "aoc5_2")
    "Don't reorder the stacks for part two of the challenge.";
    stacks[dest] = {@stacks[source][1..amount], @stacks[dest]};
  else
    "Reverse to simulate moving one at a time.";
    stacks[dest] = {@$list_utils:reverse(stacks[source][1..amount]), @stacks[dest]};
  endif
  stacks[source] = stacks[source][amount + 1..$];
endfor
for x in [1..length(stacks)]
  player:tell(x, ": ", toliteral(stacks[x]));
endfor
player:tell(toliteral($string_utils:from_list($list_utils:slice(stacks))));
