#53:scan_token   this none this rxd

string = this.input_string;
len = this.input_length;
i = this.input_index;
while (i <= len && string[i] == " ")
  i = i + 1;
endwhile
if (i > len)
  this.index_incremented = 0;
  return "";
elseif ((ch = string[i]) in {"(", ")", "!", "?"})
  this.input_index = i + 1;
  this.index_incremented = 1;
  return ch;
elseif (ch in {"&", "|"})
  this.input_index = i = i + 1;
  this.index_incremented = 1;
  if (i <= len && string[i] == ch)
    this.input_index = i + 1;
    this.index_incremented = 2;
  endif
  return ch + ch;
else
  start = i;
  while (i <= len && !((ch = string[i]) in {"(", ")", "!", "?", "&", "|"}))
    i = i + 1;
  endwhile
  this.input_index = i;
  i = i - 1;
  while (string[i] == " ")
    i = i - 1;
  endwhile
  this.index_incremented = i - start + 1;
  return this:canonicalize_spaces(string[start..i]);
endif
