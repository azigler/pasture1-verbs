#100:@ansi-t*est   none none none rd

"Usage:  @ansi-test";
"Displays a screen that uses all of the ANSI codes possible.  Useful for testing which codes your terminal program is capable of displaying.";
player:notify($string_utils:center(tostr(" ANSI Test Screen "), l = player:linelen(), "-"));
player:notify_lines($ansi_utils.test_screen);
player:notify($string_utils:space(l, "-"));
