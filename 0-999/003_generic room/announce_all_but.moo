#3:announce_all_but   this none this rxd

":announce_all_but(LIST objects to ignore, text)";
{ignore, @text} = args;
contents = this:contents();
for l in (ignore)
  contents = setremove(contents, l);
endfor
for listener in (contents)
  try
    listener:tell(@text);
  except (ANY)
    "Ignure listener with bad :tell";
    continue listener;
  endtry
endfor
