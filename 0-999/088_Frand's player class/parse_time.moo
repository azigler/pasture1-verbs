#88:parse_time   this none this rxd

"'parse_time (<words>)' -> <seconds> - Given a list of zero or more words, either empty or a valid time expression, return the number of seconds that the time expression refers to. This is a duration, not an absolute time.";
words = args[1];
"If the list is empty, return the default refusal time.";
if (!words)
  return this.default_refusal_time;
endif
"If the list has one word, either <units> or <n>.";
"If it is a unit, like 'hour', return the time for 1 <unit>.";
"If it is a number, return the time for <n> days.";
if (length(words) == 1)
  return this:time_word_to_seconds(words[1]) || toint(words[1]) * this:time_word_to_seconds("days");
endif
"The list must contain two words, <n> <units>.";
return toint(words[1]) * this:time_word_to_seconds(words[2]);
