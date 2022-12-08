#6:last_connect_time   this none this rxd

if (this in connected_players())
  return 0;
else
  return this.last_connected_time;
endif
"Last modified Thu Dec  8 07:32:14 2022 UTC by caranov (#133).";
