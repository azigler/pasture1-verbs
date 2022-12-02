#97:tell_key   this none this rxd

"This makes a URL key for a specific object and player.";
"With the keyed URL, the PLAYER will be set correctly when :HTML() is called";
key = this:gen_key(player, caller);
notify(player, "This is the private key for you, " + player.name + ". Do not share it.");
notify(player, "http://" + $network.site + ":" + $network.port + "/" + tostr(caller)[2..$] + "/" + tostr(player)[2..$] + "/" + key + "/");
