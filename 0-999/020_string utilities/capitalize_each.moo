#20:capitalize_each   this none this rxd

"This will capitalize each word in a string.";
"Add words to the ignore list if you want them to be left lowercase.";
{string, ?ignore_words = {}, ?always_capitalize_first = 1} = args;
words = $string_utils:words(string);
for x in [1..length(words)]
  if (!(words[x] in ignore_words) || (x == 1 && always_capitalize_first))
    words[x] = $string_utils:capitalize(words[x]);
  endif
endfor
return $string_utils:from_list(words, " ");
