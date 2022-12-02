#100:linesplit   this none this rxd

":linesplit(line,len) => list of substrings of line";
"used by :notify to split up long lines if .linelen>0";
line = args[1];
len = args[2];
cline = {};
au = $ansi_utils;
"..this should eventually return E_RANGE or \"\" and stop...";
while (z = au:cutoff(line, 1, len + 1))
  cutoff = au:rindex(z[1..length(z) - 1], " ");
  if (nospace = cutoff < 4 * len / 5)
    cutoff = len + 1;
    nospace = index(au:cutoff(line, cutoff, cutoff), " ");
  endif
  q = au:cutoff_locs(line, 1, cutoff - 1, 1);
  cline = {@cline, line[q[1]..q[2]]};
  line[q[1]..q[2]] = nospace ? " " | "";
endwhile
return {@cline, line};
