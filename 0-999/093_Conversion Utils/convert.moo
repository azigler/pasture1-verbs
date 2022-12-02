#93:convert   this none this rxd

":convert(STR <units>, STR <units>) => FLOAT conversion factor | LIST errors.";
"This verb attempts to compute the conversion factor between two sets of units. If the two inputs are of the same type (two speeds, two lengths, etc.), the value is returned. If the two inputs are not of the same type, a LIST is returned as follows: {1, {FLOAT <value>, STR <units>}. {FLOAT <value>, STR <units>}}. The 1 indicates that the two inputs were correctly formed. <value> is the conversion factor of the input into the basic <units>. This error output is useful for determining the basic structure and value of an unknown unit of measure. If either of the inputs can not be broken down to known units, a LIST is returned as follows: {0, STR <bad input>}.";
"";
"The format of the input strings is fairly straight forward: any multiplicative combination of units, ending in an optional digit to represent that unit is raised to a power, the whole of which is preceeded by an initial value. Examples: \"100 kg m/sec2\", \"35 joules\", \"2000 furlongs/fortnight\"";
"";
"Some example uses:";
";$convert_utils:convert(\"2000 furlongs/fortnight\", \"mph\")";
"=> 0.744047619047619";
";$convert_utils:convert(\"kilowatt hours\", \"joules\")";
"=> 3600000.0";
"";
";$convert_utils:convert(\"furlongs\", \"mph\")";
"=> {1, {201.168, \"m\"}, {044704, \"m / s\"}}";
"";
";$convert_utils:convert(\"junk\", \"meters\")";
"=> {0, \"junk\"}";
{havestr, wantstr} = args;
{havenum, havestr} = $string_utils:first_word(havestr);
havestr = $string_utils:trimr(tostr(havenum, " ", strsub(havestr, " ", "")));
wantstr = strsub(wantstr, " ", "");
"Preceeding three lines added by GD (#110777) on 23-June-2007 to stop an annoying error when you try to convert to/from things like 'fluid ounces'.";
have = this:_do_convert(havestr);
want = this:_do_convert(wantstr);
if (have && want && have[2] == want[2])
  return have[1] / want[1];
elseif (have && want)
  return {1, {have[1], this:_format_units(@have[2])}, {want[1], this:_format_units(@want[2])}};
else
  return {0, have ? wantstr | havestr};
endif
