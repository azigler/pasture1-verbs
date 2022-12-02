#47:check_answer_flags   this none this rxd

flags = {};
for o in ({"all", "include", "followup"})
  if (player:mail_option(o))
    flags = {@flags, o};
  endif
endfor
reply_to = player:mail_option("replyto") || {};
flaglist = "+1#include -1#noinclude +2#all -2#sender 0#replyto +3#followup ";
for a in (args)
  if (i = index(a, "="))
    value = a[i + 1..$];
    a = a[1..i - 1];
  else
    value = "";
  endif
  if (typeof(a) != STR || (i = index(flaglist, "#" + a)) < 3)
    player:tell("Unrecognized answer/reply option:  ", a);
    return 0;
  elseif (i != rindex(flaglist, "#" + a))
    player:tell("Ambiguous answer/reply option:  ", a);
    return 0;
  elseif (j = index("0123456789", flaglist[i - 1]) - 1)
    if (value)
      player:tell("Flag does not take a value:  ", a);
      return 0;
    endif
    f = {"include", "all", "followup"}[j];
    flags = flaglist[i - 2] == "+" ? setadd(flags, f) | setremove(flags, f);
    if (f == "all")
      flags = setremove(flags, "followup");
    endif
  elseif (!value || (value = this:parse_recipients({}, $string_utils:explode(value), "replyto flag:  ")))
    reply_to = value || {};
  endif
endfor
return {flags, reply_to};
