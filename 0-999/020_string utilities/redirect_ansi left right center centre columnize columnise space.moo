#20:"redirect_ansi left right center centre columnize columnise space"   this none this rx

"...redirects verbs to $ansi_utils...";
if (verb == "redirect_ansi")
elseif (valid(au = $ansi_utils))
  return au:(verb)(@args);
else
  return this:(verb + "(noansi)")(@args);
endif
