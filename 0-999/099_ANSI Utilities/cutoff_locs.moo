#99:cutoff_locs   this none this rx

":cutoff_locs (STR string,NUM start,NUM end[,NUM extra][, NUM suspendok])";
"                                                       => {nstart, nend}";
"Takes <start> and <end>, fixes them to compensate for the ANSI codes, and";
"returns them.  If <extra> is provided and true, <nend> will include the";
"codes after the ending letter.";
start = args[2];
end = args[3];
if (typeof(string = args[1]) != STR)
  return E_INVARG;
elseif (!(index(string, "[") && this.active))
  return {start, end == "$" ? length(string) | end};
elseif (start > end)
  return args[2..3];
endif
i = begin = 0;
x = 1;
extra = {@args, 0}[4];
reg = this.all_regexp;
l = length(string);
suspendok = {@args, 0}[5];
while (x <= l)
  suspendok && (ticks_left() < 1000 || seconds_left() < 2) && player:tell("suspending...") && suspend(0);
  if (m = match(string, reg))
    i = i + (m[1] - 1);
    if (!begin && i + 1 >= start)
      begin = x + m[1] - i + start - 2;
      if (end == "$")
        return {begin, l};
      endif
    endif
    if (begin && i - extra >= end)
      return {begin, x + m[1] - i + end - 2};
    endif
    x = x + m[2];
    string[1..m[2]] = "";
  else
    return {begin || x - i + start - 1, end == "$" ? l | x - i + end - 1};
  endif
endwhile
return end == i && begin ? {begin, l} | E_RANGE;
