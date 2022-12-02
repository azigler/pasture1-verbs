#3:announce_lines_x   this none this rxd

"Copied from generic room (#3):announce by Haakon (#2) Thu Oct 24 16:15:01 1996 PDT";
for dude in (setremove(this:contents(), player))
  try
    dude:tell_lines(@args);
  except id (ANY)
  endtry
endfor
