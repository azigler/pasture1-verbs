#30:index   this none this rxd

"{\"*index*\" [, title]}";
"This produces a columnated list of topics in this help db, headed by title.";
$command_utils:suspend_if_needed(0);
title = args[1] ? args[1][1] | tostr(this.name, " (", this, ")");
su = $string_utils;
return {"", title, su:from_list($list_utils:map_arg(su, "space", su:explode(title), "-"), " "), @this:columnize(@this:sort_topics(this:find_topics()))};
