#50:subst_regexp   this none this rxd

"Copied from Domain (#8111):subst_regexp by Mooshie (#106469) Mon Jan  5 19:27:26 1998 PST";
"Usage: subst_regexp(STR text, STR from string, STR to string, INT case)";
{text, from, to, case} = args;
if (m = match(text, from, case))
  {start, end} = m[1..2];
  text[start..end] = substitute(to, m);
  return text;
else
  return m;
endif
