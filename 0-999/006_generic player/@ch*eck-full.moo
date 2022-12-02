#6:@ch*eck-full   any any any rd

responsible = $paranoid_db:get_data(this);
if (length(verb) <= 6)
  "@check, not @check-full";
  n = 5;
  trust = {this, $no_one};
  "... trust no one, my friend.... no one....  --Herod";
  mistrust = {};
  for k in (args)
    if (z = $code_utils:toint(k))
      n = z;
    elseif (k[1] == "!")
      mistrust = listappend(mistrust, $string_utils:match_player(k[2..$]));
    else
      trust = listappend(trust, $string_utils:match_player(k));
    endif
  endfor
  msg_width = player:linelen() - 60;
  for q in (n > (y = length(responsible)) ? responsible | responsible[y - n + 1..y])
    msg = tostr(@q[2]);
    if (length(msg) > msg_width)
      msg = msg[1..msg_width];
    endif
    s = this:whodunnit(q[1], trust, mistrust);
    text = valid(s[1]) ? s[1].name | "** NONE **";
    this:notify(tostr($string_utils:left(tostr(length(text) > 13 ? text[1..13] | text, " (", s[1], ")"), 20), $string_utils:left(s[2], 15), $string_utils:left(tostr(length(s[3].name) > 13 ? s[3].name[1..13] | s[3].name, " (", s[3], ")"), 20), msg));
  endfor
  this:notify("*** finished ***");
else
  "@check-full, from @traceback by APHiD";
  "s_i_n's by Ho_Yan 10/18/94";
  matches = {};
  if (length(match = argstr) == 0)
    player:notify(tostr("Usage: ", verb, " <string> --or-- ", verb, " <number>"));
    return;
  endif
  if (!responsible)
    player:notify("No text has been saved by the monitor.  (See `help @paranoid').");
  else
    if (typeof(x = $code_utils:toint(argstr)) == ERR)
      for line in (responsible)
        if (index(tostr(@line[$]), argstr))
          matches = {@matches, line};
        endif
      endfor
    else
      matches = responsible[$ - min(x, $) + 1..$];
    endif
    if (matches)
      for match in (matches)
        $command_utils:suspend_if_needed(3);
        text = tostr(@match[$]);
        player:notify("Traceback for:");
        player:notify(text);
        "Moved cool display code to $code_utils, 3/29/95, Ho_Yan";
        $code_utils:display_callers(listdelete(mm = match[1], length(mm)));
      endfor
      player:notify("**** finished ****");
    else
      player:notify(tostr("No matches for \"", argstr, "\" found."));
    endif
  endif
endif
