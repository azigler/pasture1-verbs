#59:commentify   this none this rxd

"Usage:  commentify(lines)";
"";
"Given lines of text, translate them into comment strings and return the list.";
{lines} = args;
out = {};
for line in (lines)
  out = {@out, $string_utils:print(line) + ";"};
endfor
return out;
