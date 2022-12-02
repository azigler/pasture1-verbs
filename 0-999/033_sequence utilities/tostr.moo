#33:tostr   this none this rxd

"tostr(seq [,delimiter]) -- turns a sequence into a string, delimiting ranges with delimiter, defaulting to .. (e.g. 5..7)";
{seq, ?separator = ".."} = args;
if (!seq)
  return "empty";
endif
e = tostr(seq[1] == $minint ? "" | seq[1]);
len = length(seq);
for i in [2..len]
  e = e + (i % 2 ? tostr(", ", seq[i]) | (seq[i] == seq[i - 1] + 1 ? "" | tostr(separator, seq[i] - 1)));
endfor
return e + (len % 2 ? separator | "");
