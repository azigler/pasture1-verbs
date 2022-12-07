#99:ansi_title   this none this rx

":ansi_title (OBJ player[, STR name]) => STR <player>'s title";
"If <name> is specified, it will be used instead of <player>.name";
name = {@args, args[1].name}[2];
for x in (args[1].ansi_title)
  if (typeof(x[2]) == LIST)
    nn = x[2][random(length(x[2]))];
  else
    nn = x[2];
  endif
  nn && (name = strsub(name, x[1], nn));
endfor
afk_marker = "";
if (args[1] in $global_chat.afk_list)
  afk_marker = " [AFK]";
endif
poses = "";
if (is_player(what = args[1]) && what.poses)
  poses = "(" + $string_utils:from_list(what.poses, ", ") + ")";
endif
return $string_utils:capitalize(name) + afk_marker + poses;
"Last modified Wed Dec  7 17:46:47 2022 UTC by caranov (#133).";
