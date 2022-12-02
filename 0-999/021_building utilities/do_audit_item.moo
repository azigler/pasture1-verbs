#21:do_audit_item   this none this rxd

":do_audit_item(object, match-name-string, prospectus-flag)";
{o, match, pros} = args;
found = match ? 0 | 1;
names = `{o.name, @o.aliases} ! ANY => {o.name}';
"Above to get rid of screwed up aliases";
while (names && !found)
  if (index(names[1], match) == 1)
    found = 1;
  endif
  names = listdelete(names, 1);
endwhile
if (found)
  "From Dred---don't wrap long lines.";
  line = $building_utils:object_audit_string(o, pros);
  player:tell(line[1..min($, player:linelen())]);
  return 1;
endif
return 0;
