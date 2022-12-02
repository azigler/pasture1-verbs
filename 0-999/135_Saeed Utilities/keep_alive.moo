#135:keep_alive   this none this xd

for x in (connected_players())
  idle_seconds(x) >= 240 && x.keep_alive && x:tell("#$#keep_alive");
  yin();
endfor
