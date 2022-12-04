#171:fetch   this none this rxd

":fetch()";
"Fetch the most recent Advent of Code 2022 private leaderboard stats.";
"These stats come from my personal server as I didn't think it was wise to throw my session cookie around willynilly.";
MAX_TIME = 60 * 5;
if (time() - this.last_fetch < MAX_TIME)
  return this.cache;
else
  try
    "Let's just GO FOR IT. Error checking shmerror checking.";
    this.cache = parse_json(curl("https://cfsg.toastsoft.net/adventofcode2022/")[1][1]);
    this.last_fetch = time();
  except error (ANY)
    #139:tell("[bold][red]ADVENT OF CODE FETCH ERROR[normal]: ", toliteral(error));
  endtry
endif
