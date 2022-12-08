#6:last_connect_time   this none this rxd

if (this in connected_players())
  return 0;
else
  return this.last_connect_time;
endif
"Last modified Thu Dec  8 10:00:08 2022 UTC by caranov (#133).";
