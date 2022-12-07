#180:damage   this none this rxd

loc = this.location;
isa(loc, $room) == 0 && (loc = loc.location);
loc:announce_all(this:title() + " jerks and shudders as whaling souls burst from within, spectral claws and nashing teeth gradually nawing away at the great bones of Xahrin.");
this.soulshards = this.soulshards - frandom(140.0, 180.0);
this.endurance = this.endurance - frandom(65.0, 85.0);
"Last modified Wed Dec  7 07:18:17 2022 UTC by caranov (#133).";
