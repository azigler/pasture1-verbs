#20:incr_alpha   this none this rxd

"args[1] is a string.  'increments' the string by one. E.g., aaa => aab, aaz => aba.  empty string => a, zzz => aaaa.";
"args[2] is optional alphabet to use instead of $string_utils.alphabet.";
{s, ?alphabet = this.alphabet} = args;
index = length(s);
if (!s)
  return alphabet[1];
elseif (s[$] == alphabet[$])
  return this:incr_alpha(s[1..index - 1], alphabet) + alphabet[1];
else
  t = index(alphabet, s[index]);
  return s[1..index - 1] + alphabet[t + 1];
endif
