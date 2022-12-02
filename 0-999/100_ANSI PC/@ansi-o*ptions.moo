#100:@ansi-o*ptions   any any any rd

"@ansi-option <option> [is] <value>   sets <option> to <value>";
"@ansi-option <option>=<value>        sets <option> to <value>";
"@ansi-option +<option>     sets <option>   (usually equiv. to <option>=1";
"@ansi-option -<option>     resets <option> (equiv. to <option>=0)";
"@ansi-option !<option>     resets <option> (equiv. to <option>=0)";
"@ansi-option <option>      displays value of <option>";
if (!args)
  player:notify_lines({"Current ANSI options:", "", @$options["ansi"]:show(this.ansi_options, $options["ansi"].names)});
  return;
elseif (typeof(presult = $options["ansi"]:parse(args)) == STR)
  player:notify(presult);
  return;
else
  if (length(presult) > 1)
    if (typeof(sresult = this:set_ansi_option(@presult)) == STR)
      player:notify(sresult);
      return;
    elseif (!sresult)
      player:notify("No change.");
      return;
    endif
  endif
  player:notify_lines($options["ansi"]:show(this.ansi_options, presult[1]));
endif
