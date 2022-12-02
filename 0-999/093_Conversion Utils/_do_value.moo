#93:_do_value   this none this rxd

"THIS VERB IS NOT INTENDED FOR USER USAGE.";
":_do_value takes a string of the form <number>|<number>, interprets it as a ratio, and applies that ratio to the incoming 'value' accordingly with the 'top' input, and returns it back to the calling verb.";
{first, value, top} = args;
{numer, denom} = $string_utils:explode(first, "|");
return top ? value * tofloat(numer) / tofloat(denom) | value * tofloat(denom) / tofloat(numer);
