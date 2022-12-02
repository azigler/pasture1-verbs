#20:"columnize_suspended columnise_suspended"   this none this rxd

"columnize_suspended (interval, items, n [, width]) - Turn a one-column list of items into an n-column list, suspending for `interval' seconds as necessary. 'width' is the last character position that may be occupied; it defaults to a standard screen width. Example: To tell the player a list of numbers in three columns, do 'player:tell_lines ($string_utils:columnize_suspended(0, {1, 2, 3, 4, 5, 6, 7}, 3));'.";
{interval, items, n, ?width = 79} = args;
height = (length(items) + n - 1) / n;
items = {@items, @$list_utils:make(height * n - length(items), "")};
colwidths = {};
for col in [1..n - 1]
  colwidths = listappend(colwidths, 1 - (width + 1) * col / n);
endfor
result = {};
for row in [1..height]
  line = tostr(items[row]);
  for col in [1..n - 1]
    $command_utils:suspend_if_needed(interval);
    line = tostr(this:left(line, colwidths[col]), " ", items[row + col * height]);
  endfor
  result = listappend(result, line[1..min($, width)]);
endfor
return result;
