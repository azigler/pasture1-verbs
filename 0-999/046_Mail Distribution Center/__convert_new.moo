#46:__convert_new   this none this rxd

":__convert_new(@msg) => msg in new format (if it isn't already)";
"               ^ don't forget the @ here.";
"If the msg is already in the new format it passes through unchanged.";
"If the msg format is unrecognizable, warnings are printed.";
if (typeof(date = args[1]) != INT)
  date = 0;
  start = 1;
else
  start = 2;
  if (!((colon = index(args[2], ":")) && args[2][1..colon] in {"From:", "To:", "Subject:"}))
    return args;
  endif
endif
from = to = 0;
subject = " ";
blank = "" in {@args, ""};
newhdr = {};
for line in (args[start..blank - 1])
  if (index(line, "Date:") == 1)
    if (date)
      player:notify("Warning: two dates?");
    endif
    date = $time_utils:from_ctime(line[6..$]);
  elseif (index(line, "From:") == 1)
    if (from)
      player:notify("Warning: two from-lines?");
    endif
    from = $string_utils:triml(line[6..$]);
  elseif (index(line, "To:") == 1)
    if (to)
      player:notify("Warning: two to-lines?");
    endif
    to = $string_utils:triml(line[6..$]);
  elseif (index(line, "Subject:") == 1)
    subject = $string_utils:triml(line[9..$]);
  else
    newhdr = {@newhdr, line};
  endif
endfor
if (!from)
  player:notify("Warning: no from-line.");
endif
if (!to)
  player:notify("Warning: no to-line.");
endif
return {date, from, to, subject, @newhdr, @args[blank..$]};
