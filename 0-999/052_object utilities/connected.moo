#52:connected   this none this rxd

":connected(object) => true if object is a connected player.";
"equivalent to (object in connected_players()) for valid players, perhaps with less server overhead.";
"use object:is_listening() if you want to allow for puppets and other non-player objects that still 'care' about what's said.";
return typeof(`connected_seconds(@args) ! E_INVARG') == INT;
