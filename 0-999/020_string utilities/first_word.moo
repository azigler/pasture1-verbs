#20:first_word   this none this rxd

":first_word(string) => {first word, rest of string} or {}";
rest = args[1];
"...trim leading blanks...";
rest[1..match(rest, "^ *")[2]] = "";
if (!rest)
  return {};
endif
quote = 0;
token = "";
pattern = " +%|\\.?%|\"";
while (m = match(rest, pattern))
  "... find the next occurence of a special character, either";
  "... a block of spaces, a quote or a backslash escape sequence...";
  char = rest[m[1]];
  token = token + rest[1..m[1] - 1];
  if (char == " ")
    rest[1..m[2]] = "";
    return {token, rest};
  elseif (char == "\"")
    "... beginning or end of quoted string...";
    "... within a quoted string spaces aren't special...";
    pattern = (quote = !quote) ? "\\.?%|\"" | " +%|\\.?%|\"";
  elseif (m[1] < m[2])
    "... char has to be a backslash...";
    "... include next char literally if there is one";
    token = token + rest[m[2]];
  endif
  rest[1..m[2]] = "";
endwhile
return {token + rest, ""};
