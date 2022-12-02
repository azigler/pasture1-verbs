#32:guess_words   this none this rxd

{nastyword} = args;
guesses = spellcheck(nastyword);
"Transpose adjacent characters";
nastyword = nastyword + " ";
for i in [1..length(nastyword) - 1]
  foo = nastyword[1..i - 1] + nastyword[i + 1] + nastyword[i] + nastyword[i + 2..$];
  foo = $string_utils:trim(foo);
  if (this:valid(foo))
    guesses = setadd(guesses, foo);
  endif
  if (ticks_left() < 500 || seconds_left() < 2)
    suspend(0);
  endif
endfor
nastyword = $string_utils:trim(nastyword);
"Erase each character - check for an extra typoed character";
for i in [1..length(nastyword)]
  foo = nastyword[1..i - 1] + nastyword[i + 1..$];
  if (this:valid(foo))
    guesses = setadd(guesses, foo);
  endif
  if (ticks_left() < 500 || seconds_left() < 2)
    suspend(0);
  endif
endfor
"Alter one character";
for i in [1..length(nastyword)]
  for ii in ({"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "'", "-"})
    foo = nastyword[1..i - 1] + ii + nastyword[i + 1..$];
    if (this:valid(foo))
      guesses = setadd(guesses, foo);
    endif
  endfor
  if (ticks_left() < 500 || seconds_left() < 2)
    suspend(0);
  endif
endfor
"insert one character";
for i in [1..length(nastyword)]
  for ii in ({"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "'", "-"})
    foo = nastyword[1..i - 1] + ii + nastyword[i..$];
    if (this:valid(foo))
      guesses = setadd(guesses, foo);
    endif
  endfor
  if (ticks_left() < 500 || seconds_left() < 2)
    suspend(0);
  endif
endfor
"Clean up and go home";
guesses = $list_utils:sort(guesses);
return guesses;
