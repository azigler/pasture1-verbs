#99:delete   this none this rxd

":delete (STR string) => STR <string> with ANSI codes stripped out";
line = args[1];
if (this.active)
  while (index = match(line, this.notify_regexp))
    line[index[1]..index[2]] = "";
  endwhile
  line = strsub(line, "[null]", "");
endif
return line;
