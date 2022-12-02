#155:tag_title_list   this none this rxd

":tag_title_list(LIST <tag IDs>) => STR";
"Return a string of <tag IDs> spaced with tabs.";
"e.g. some tag    another tag    more tags";
{ids} = args;
tags = {};
for x in (ids)
  tags = setadd(tags, this:display_tag(x));
endfor
"$string_utils.tab donks everything up, so we use four spaces. Tabs vs spaces argument over I suppose!";
return $string_utils:from_list(tags, "    ");
