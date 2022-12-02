#39:check   this none none rxd

":check() -- checks for recycled and toaded players that managed not to get expunged from the db.";
for p in (properties($player_db))
  if (ticks_left() < 500 || seconds_left() < 2)
    player:tell("...", p);
    suspend(0);
  endif
  if (p[1] == " ")
    nlist = this.(p)[3];
    olist = this.(p)[4];
    for i in [1..length(nlist)]
      if (valid(olist[i]) && (is_player(olist[i]) && nlist[i] in olist[i].aliases))
      else
        player:tell(".", p[2..$], " <- ", nlist[i], " ", olist[i]);
      endif
    endfor
  endif
endfor
player:tell("done.");
