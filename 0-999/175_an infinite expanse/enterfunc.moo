#175:enterfunc   this none this rxd

{what} = args;
if (is_player(what) == 1 && maphaskey(this.voidcatchers, what) == 0)
  voidbound = this:has_pole(player);
  this.voidcatchers[player] = 0;
endif
what:tell("A chill runs down your spine as you drop into the utter dark that is the void. ", voidbound != 0 && "The void attempts to intimidate you, sending foreign visions into your mind which no man was meant to see. It senses your focus, the soulbound rod which contains enough potential to cause devastation powerful enough to tear this realm asunder." || "Your weakness is evident. and this is what it shall feed upon. Your mind is assaulted by foreign visions that you were never meant to comprehend; It knows you do not have the ultimate devistator; the soulbound voidcatcher's pole. You cannot tame it, but it will tame you.");
voidbound == 0 && what:freeze(20);
return this:look_self(what.brief);
"Last modified Tue Dec  6 17:41:29 2022 UTC by caranov (#133).";
