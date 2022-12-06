#175:enterfunc   this none this rxd

{what} = args;
if (is_player(what) == 1 && maphaskey(this.voidcatchers, what) == 0)
  voidbound = 0;
  #133:tell("activated");
  for i in (what.contents)
    if (parent(i) == #180 && i.owner == what)
      #133:tell(voidbound);
      this.voidcatchers[what] = 0;
      this.voidcatchers[what] = i;
      voidbound = 1;
      break;
    endif
  endfor
  #133:tell(voidbound);
endif
#133:tell(voidbound);
voidbound = maphaskey(this.voidcatchers, player) && this.voidcatchers[what] != 0;
#133:tell(voidbound);
what:tell("A chill runs down your spine as you drop into the utter dark that is the void. ", voidbound == 1 && "The void attempts to intimidate you, sending foreign visions into your mind which no man was meant to see. It senses your focus, the soulbound rod which contains enough potential to cause devastation powerful enough to tear this realm asunder." || "Your weakness is evident. and this is what it shall feed upon. Your mind is assaulted by foreign visions that you were never meant to comprehend; It knows you do not have the ultimate devistator; the soulbound voidcatcher's pole. You cannot tame it, but it will tame you.");
voidbound == 0 && what:freeze(20);
return this:look_self(what.brief);
"Last modified Tue Dec  6 09:22:29 2022 UTC by caranov (#133).";
