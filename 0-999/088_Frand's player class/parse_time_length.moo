#88:parse_time_length   this none this rxd

"'parse_time_length (<words>)' -> n - Given a list of words which is expected to begin with a time expression, return how many of them belong to the time expression. A time expression can be a positive integer, a time word, or a positive integer followed by a time word. A time word is anything that this:time_word_to_seconds this is one. The return value is 0, 1, or 2.";
words = {@args[1], "dummy"};
n = 0;
if (toint(words[1]) || this:time_word_to_seconds(words[1]))
  n = 1;
endif
if (this:time_word_to_seconds(words[n + 1]))
  n = n + 1;
endif
return n;
