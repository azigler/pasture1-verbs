#149:autoreplaydelete   this none this rxd

for i in (connected_players())
  if (abs(i.last_replay_wipe - time()) > 600)
    i:wipe_replay();
  endif
endfor
fork (600)
  this:(verb)();
endfork
"Last modified Thu Dec  8 09:08:35 2022 UTC by caranov (#133).";
