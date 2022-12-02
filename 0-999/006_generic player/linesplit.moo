#6:linesplit   this none this rxd

":linesplit(line,len) => list of substrings of line";
"used by :notify to split up long lines if .linelen>0";
{line, len} = args;
cline = {};
while (length(line) > len)
  cutoff = rindex(line[1..len], " ");
  if (nospace = cutoff < 4 * len / 5)
    cutoff = len + 1;
    nospace = line[cutoff] != " ";
  endif
  cline = {@cline, line[1..cutoff - 1]};
  line = (nospace ? " " | "") + line[cutoff..$];
endwhile
return {@cline, line};
