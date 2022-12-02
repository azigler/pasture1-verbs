#43:time_sub   this none this rxd

"Works like pronoun substitution, but substitutes time stuff.";
"Call with time_sub(string, time). returns a string.";
"time is an optional integer in time() format.  If omitted, time() is used.";
"Macros which are unknown are ignored. $Q -> the empty string.";
"Terminal $ are ignored.";
"$H -> hour #. $M -> min #. $S -> second #. 24-hour format, fixed width.";
"$h, $m, $s same x/c have not-fixed format. 00:03:24 vs. 0:3:24";
"$O/$o -> numeric hour in 12-hour format.";
"$D -> long day name. $d -> short day name.";
"$N -> long month name. $n -> short month name.";
"$Y -> long year # (e.g. '1991'). $y -> short year # (e.g. '91')";
"$Z -> the time zone    (added in by r'm later)";
"$P/$p -> AM/PM, or am/pm.";
"$T -> date number. $t -> date number with no extra whitespace etc.";
"$1 -> Month in fixed-width numeric format (01-12)   (added by dpk)";
"$2 -> Month in nonfixed numeric format (1-12)";
"$3 -> Date in fixed-width format, 0-fill";
"$$ -> $.";
"";
"This verb stolen from Ozymandias's #4835:time_subst.";
res = "";
{thestr, ?thetime = time()} = args;
if (typeof(thestr) != STR || typeof(thetime) != INT)
  player:tell("Bad arguments to time_subst.");
  return;
endif
itslength = length(thestr);
if (!itslength)
  return "";
endif
done = 0;
cctime = ctime(thetime);
while (dollar = index(thestr, "$"))
  res = res + thestr[1..dollar - 1];
  if (dollar == length(thestr))
    return res;
  endif
  thechar = thestr[dollar + 1];
  thestr[1..dollar + 1] = "";
  if (thechar == "$")
    res = res + "$";
  elseif (!strcmp(thechar, "h"))
    res = res + $string_utils:trim(tostr(toint(cctime[12..13])));
  elseif (thechar == "H")
    res = res + cctime[12..13];
  elseif (!strcmp(thechar, "m"))
    res = res + $string_utils:trim(tostr(toint(cctime[15..16])));
  elseif (thechar == "M")
    res = res + cctime[15..16];
  elseif (!strcmp(thechar, "s"))
    res = res + $string_utils:trim(tostr(toint(cctime[18..19])));
  elseif (thechar == "S")
    res = res + cctime[18..19];
  elseif (!strcmp(thechar, "D"))
    res = res + $time_utils:day(thetime);
  elseif (thechar == "d")
    res = res + cctime[1..3];
  elseif (!strcmp(thechar, "N"))
    res = res + $time_utils:month(thetime);
  elseif (thechar == "n")
    res = res + cctime[5..7];
  elseif (!strcmp(thechar, "T"))
    res = res + cctime[9..10];
  elseif (thechar == "t")
    res = res + $string_utils:trim(cctime[9..10]);
  elseif (!strcmp(thechar, "o"))
    res = tostr(res, (toint(cctime[12..13]) + 11) % 12 + 1);
  elseif (thechar == "O")
    res = res + $string_utils:right(tostr((toint(cctime[12..13]) + 11) % 12 + 1), 2, "0");
  elseif (!strcmp(thechar, "p"))
    res = res + (toint(cctime[12..13]) >= 12 ? "pm" | "am");
  elseif (thechar == "P")
    res = res + (toint(cctime[12..13]) >= 12 ? "PM" | "AM");
  elseif (!strcmp(thechar, "y"))
    res = res + cctime[23..24];
  elseif (thechar == "Y")
    res = res + cctime[21..24];
  elseif (thechar == "Z")
    res = res + cctime[26..$];
  elseif (thechar == "1")
    res = res + $string_utils:right(tostr($string_utils:explode(cctime)[2] in this.monthabbrs), 2, "0");
  elseif (thechar == "2")
    res = res + tostr($string_utils:explode(cctime)[2] in this.monthabbrs);
  elseif (thechar == "3")
    res = res + $string_utils:subst(cctime[9..10], {{" ", "0"}});
  endif
endwhile
return res + thestr;
