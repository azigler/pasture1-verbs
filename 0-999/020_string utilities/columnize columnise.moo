#20:"columnize columnise"   this none this rxd

"columnize (items, n [, width]) - Turn a one-column list of items into an n-column list. 'width' is the last character position that may be occupied; it defaults to a standard screen width. Example: To tell the player a list of numbers in three columns, do 'player:tell_lines ($string_utils:columnize ({1, 2, 3, 4, 5, 6, 7}, 3));'.";
{items, n, ?width = 79} = args;
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
    line = tostr(this:left(line, colwidths[col]), " ", items[row + col * height]);
  endfor
  result = listappend(result, line[1..min($, width)]);
endfor
return result;
