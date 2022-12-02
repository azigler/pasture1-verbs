#6:is_listening   this none this rxd

"return true if player is active.";
return typeof(`idle_seconds(this) ! ANY') != ERR;
