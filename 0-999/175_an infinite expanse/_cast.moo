#175:_cast   this none this rxd

caller == this || raise(E_PERM);
if ((pole = this:has_pole(player)) == 0)
  return;
endif
this.voidcatchers[player] = 1;
player:tell("Agonizing pain explodes across your body as you raise " + pole:title() + " above your head and cast the tip into the depths. Racing lines of shadowy thread suddenly explode outward around your form, attracting the lost souls dwelling within the void.");
"Last modified Tue Dec  6 17:43:41 2022 UTC by caranov (#133).";
