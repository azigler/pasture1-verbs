#56:dump_lines   this none this rxd

":dump_lines(text) => text `.'-quoted for :read_lines()";
"  text is assumed to be a list of strings";
"Returns a corresponding list of strings which, when read via :read_lines, ";
"produces the original list of strings (essentially, any strings beginning ";
"with a period \".\" have the period doubled).";
"The list returned includes a final \".\"";
text = args[1];
newtext = {};
i = lasti = 0;
for line in (text)
  if (match(line, "^%(%.%| *@abort *$%)"))
    newtext = {@newtext, @i > lasti ? text[lasti + 1..i] | {}, "." + line};
    lasti = i = i + 1;
  else
    i = i + 1;
  endif
endfor
return {@newtext, @i > lasti ? text[lasti + 1..i] | {}, "."};
