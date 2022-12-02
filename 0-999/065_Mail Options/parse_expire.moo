#65:parse_expire   this none this rxd

{oname, value, data} = args;
if (typeof(value) == STR && index(value, " "))
  value = $string_utils:explode(value, " ");
  if (!value)
    return {oname, 0};
  endif
endif
if (value == 1)
  return {oname, -1};
elseif (typeof(value) == LIST)
  if (length(value) > 1)
    nval = $time_utils:parse_english_time_interval(@value);
    if (typeof(nval) == ERR)
      return "Time interval should be of a form like \"30 days, 10 hours and 43 minutes\".";
    else
      return {oname, nval};
    endif
  endif
  value = value[1];
endif
if ((nval = $code_utils:toint(value)) || nval == 0)
  return {oname, nval < 0 ? -1 | nval};
elseif (value == "Never")
  return {oname, -1};
else
  return "Number, time interval (e.g., \"30 days\"), or \"Never\" expected";
endif
