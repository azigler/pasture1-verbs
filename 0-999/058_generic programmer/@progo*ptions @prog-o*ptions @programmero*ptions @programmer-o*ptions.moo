#58:"@progo*ptions @prog-o*ptions @programmero*ptions @programmer-o*ptions"   any any any rd

"@<what>-option <option> [is] <value>   sets <option> to <value>";
"@<what>-option <option>=<value>        sets <option> to <value>";
"@<what>-option +<option>     sets <option>   (usually equiv. to <option>=1";
"@<what>-option -<option>     resets <option> (equiv. to <option>=0)";
"@<what>-option !<option>     resets <option> (equiv. to <option>=0)";
"@<what>-option <option>      displays value of <option>";
set_task_perms(player);
what = "prog";
options = what + "_options";
option_pkg = $options[what];
set_option = "set_" + what + "_option";
if (!args)
  player:notify_lines({"Current " + what + " options:", "", @option_pkg:show(this.(options), option_pkg.names)});
  return;
elseif (typeof(presult = option_pkg:parse(args)) == STR)
  player:notify(presult);
  return;
else
  if (length(presult) > 1)
    if (typeof(sresult = this:(set_option)(@presult)) == STR)
      player:notify(sresult);
      return;
    elseif (!sresult)
      player:notify("No change.");
      return;
    endif
  endif
  player:notify_lines(option_pkg:show(this.(options), presult[1]));
endif
