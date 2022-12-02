#20:_unquote   this none this rxd

"_unquote(string)   (auxiliary for :to_value())";
"reads string as if it were preceded by a quote, reading up to the closing quote if any, then returns the corresponding unquoted string.";
" => {0, string unquoted}  if there is no closing quote";
" => {original string beyond closing quote, string unquoted}  otherwise";
rest = args[1];
result = "";
while (m = match(rest, "\\.?%|\""))
  "Find the next special character";
  if (rest[pos = m[1]] == "\"")
    return {rest[pos + 1..$], result + rest[1..pos - 1]};
  endif
  result = result + rest[1..pos - 1] + rest[pos + 1..m[2]];
  rest = rest[m[2] + 1..$];
endwhile
return {0, result + rest};
