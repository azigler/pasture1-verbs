#26:base_conversion   this none this rxd

"Synopsis:    :base_conversion(number, current_base, desired_base)";
"---";
"Call with first arg either a number or a string, being the number";
"desired for conversion. capital letters denote values from 10-35;";
"lowercase letters from 36 to 61. Maximal base is 62.";
"You will be unable to use the extra 26 lowercases as separate unless";
"you pass a nonzero fourth argument. Passing zero or none uses the";
"default value, which is to have AAAA=aaaa.";
"The second and third arguments should be the base of the number and";
"the base you want it in, respectively.";
"Any of the arguments can be strings or nums, but high-base numbers";
"will need to be strings. This returns a string.";
"Any problems, talk to Ozymandias.";
sensitive = 0;
if (length(args) < 3)
  return E_INVARG;
elseif (length(args) == 4)
  sensitive = toint(args[4]);
endif
result = 0;
thenum = tostr(args[1]);
origbase = toint(args[2]);
newbase = toint(args[3]);
if (origbase < 2 || newbase < 2 || origbase > 62 || newbase > 62)
  return E_INVARG;
endif
for which in [1..length(thenum)]
  value = index(this.base_alphabet, thenum[which], sensitive);
  if (!value || value > origbase)
    return E_INVARG;
  endif
  result = result * origbase + value - 1;
endfor
thestring = "";
if (result < 0)
  return E_INVARG;
endif
while (result)
  if ((which = result % newbase + 1) <= length(this.base_alphabet))
    thestring = this.base_alphabet[which] + thestring;
  else
    return E_INVARG;
  endif
  result = result / newbase;
endwhile
return thestring ? thestring | "0";
