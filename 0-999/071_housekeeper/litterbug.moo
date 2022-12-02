#71:litterbug   this none this rxd

for room in (this.public_places)
  for thingy in (room.contents)
    suspend(10);
    if (thingy.location == room && this:is_litter(thingy) && !this:is_watching(thingy, $nothing))
      "if it is litter and no-one is watching";
      fork (0)
        this:send_home(thingy);
      endfork
      suspend(0);
    endif
  endfor
endfor
