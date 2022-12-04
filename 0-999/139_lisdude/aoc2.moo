#139:aoc2   none none none rxd

"https://adventofcode.com/2022/day/2";
"";
"All these letters, maaaan. For ease of readability, I'll map single-letter moves into English.";
moves = ["A" -> "rock", "B" -> "paper", "C" -> "scissors", "X" -> "rock", "Y" -> "paper", "Z" -> "scissors"];
winning_moves = ["rock" -> "paper", "paper" -> "scissors", "scissors" -> "rock"];
worth = ["rock" -> 1, "paper" -> 2, "scissors" -> 3];
total_score = 0;
for x in (this.aoc2)
  yin();
  {them, me} = {moves[x[1]], moves[x[3]]};
  score = worth[me];
  if (them == me)
    score = score + 3;
  elseif (winning_moves[them] == me)
    score = score + 6;
  endif
  total_score = total_score + score;
endfor
player:tell("Total score: ", total_score);
