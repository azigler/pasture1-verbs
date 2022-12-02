#20:english_number   this none this rxd

"$string_utils:english_number(n) -- convert the integer N into English";
"";
"Produces a string containing the English phrase naming the given integer.  For example, $string_utils:english_number(-1234) returns the string `negative one thousand two hundred thirty-four'.";
numb = toint(args[1]);
if (numb == 0)
  return "zero";
endif
labels = {"", " thousand", " million", " billion"};
numstr = "";
mod = abs(numb);
for n in [1..4]
  div = mod % 1000;
  if (div)
    hun = div / 100;
    ten = div % 100;
    outstr = this:english_tens(ten) + labels[n];
    if (hun)
      outstr = this:english_ones(hun) + " hundred" + (ten ? " " | "") + outstr;
    endif
    if (numstr)
      numstr = outstr + " " + numstr;
    else
      numstr = outstr;
    endif
  endif
  mod = mod / 1000;
endfor
return (numb < 0 ? "negative " | "") + numstr;
