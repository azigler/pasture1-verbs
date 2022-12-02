#99:space   this none this rxd

"space(len,fill) returns a string of length abs(len) consisting of copies of fill.  If len is negative, fill is anchored on the right instead of the left.";
n = args[1];
typeof(n) == STR && (n = this:length(n));
if (" " != (fill = {@args, " "}[2]))
  fill = fill + fill;
  fill = fill + fill;
  fill = fill + fill;
elseif ((n = abs(n)) < 70)
  return "                                                                      "[1..n];
else
  fill = "                                                                      ";
endif
m = (n - 1) / this:length(fill);
while (m)
  fill = fill + fill;
  m = m / 2;
endwhile
return n > 0 ? this:cutoff(fill, 1, n) | this:cutoff(fill, (f = this:length(fill)) + 1 + n, f);
