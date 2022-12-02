#74:help_msg   this none this rxd

all_help = this.help_msg;
if (typeof(all_help) == STR)
  all_help = {all_help};
endif
helpless = {};
for vrb in (this.feature_verbs)
  if (loc = $object_utils:has_verb(this, vrb))
    loc = loc[1];
    help = $code_utils:verb_documentation(loc, vrb);
    if (help)
      all_help = {@all_help, "", tostr(loc, ":", verb_info(loc, vrb)[3]), @help};
    else
      helpless = {@helpless, vrb};
    endif
  endif
endfor
if (helpless)
  all_help = {@all_help, "", "No help found on " + $string_utils:english_list(helpless, "nothing", " or ") + "."};
endif
return {@all_help, "----"};
