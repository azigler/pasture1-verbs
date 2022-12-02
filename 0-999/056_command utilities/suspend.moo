#56:suspend   this none this rxd

"Suspend, using output_delimiters() in case a client needs to keep track";
"of the output of the current command.";
"Args are TIME, amount of time to suspend, and optional (misnamed) OUTPUT.";
"If given no OUTPUT, just do a suspend.";
"If OUTPUT is neither list nor string, suspend and return output_delimiters";
"If OUTPUT is a list, it should be in the output_delimiters() format:";
"  {PREFIX, SUFFIX}.  Use these to handle that client stuff.";
"If OUTPUT is a string, it should be SUFFIX (output_delimiters[2])";
"";
"Proper usage:";
"The first time you want to suspend, use";
"  output_delimiters = $command_utils:suspend(time, x);";
"where x is some non-zero number.";
"Following, use";
"  $command_utils:suspend(time, output_delimiters);";
"To wrap things up, use";
"  $command_utils:suspend(time, output_delimiters[2]);";
"You'll probably want time == 0 most of the time.";
"Note: Using this from verbs called by other verbs could get pretty weird.";
{time, ?output = 0} = args;
set_task_perms(caller_perms());
value = 0;
if (!output)
  suspend(time);
else
  if (typeof(output) == LIST)
    PREFIX = output[1];
    SUFFIX = output[2];
    if (PREFIX)
      player:tell(output[2]);
    endif
    suspend(time);
    if (SUFFIX)
      player:tell(output[1]);
    endif
  elseif (typeof(output) == STR)
    if (output)
      player:tell(output);
    endif
  else
    output = output_delimiters(player);
    suspend(time);
    if (output != {"", ""})
      player:tell(output[1]);
    endif
    value = output;
  endif
endif
return output;
