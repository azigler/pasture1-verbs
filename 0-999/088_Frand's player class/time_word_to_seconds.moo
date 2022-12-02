#88:time_word_to_seconds   this none this rxd

"'time_word_to_seconds (<string>)' - The <string> is expected to be a time word, 'second', 'minute', 'hour', 'day', 'week', or 'month'. Return the number of seconds in that amount of time (a month is taken to be 30 days). If <string> is not a time word, return 0. This is used both as a test of whether a word is a time word and as a converter.";
return $time_utils:parse_english_time_interval("1", args[1]);
