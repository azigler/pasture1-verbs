#3:announce   this none this rxd

for dude in (setremove(this:contents(), player))
  try
    dude:tell(@args);
  except (ANY)
    "Just skip the dude with the bad :tell";
    continue dude;
  endtry
endfor
