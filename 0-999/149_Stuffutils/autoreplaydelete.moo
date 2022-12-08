#149:autoreplaydelete   this none this rxd

for i in (connected_players())
  i:wipe_replay();
endfor
fork (3600)
  this:(verb)();
endfork
"Last modified Thu Dec  8 07:32:51 2022 UTC by caranov (#133).";
