#175:_cast   this none this rxd

caller == this || raise(E_PERM);
if ((pole = this:has_pole(player)) == 0)
  return;
endif
this.voidcatchers[player] = 1;
player:tell("Agonizing pain explodes across your body as you raise " + pole:title() + " above your head and cast the tip into the depths. Racing lines of shadowy thread suddenly explode outward around your form, attracting the lost souls dwelling within the void.");
pole:damage();
fork (random(5, 15))
  this:attract();
endfork
"Last modified Thu Dec  8 08:40:56 2022 UTC by caranov (#133).";
