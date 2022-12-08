#175:cast   any any any rxd

if (this:has_pole(player) == 0)
  player:tell("Baring the roar of thunder and raging rivers. \"You were never fated to be a voidcatchr without a cznae. Depart this land, at once!\"");
  $you:say_action("The darkness churns and roils as shadowy tentacles burst from the earth. They solidify into long, furiously lashing whips that send %N flying high above the void.");
  ref = 0;
  while (player.location == this)
    if (ref > 10)
      player:moveto(player.home);
      break;
    endif
    player:moveto(descendants($room):random_element());
    ref = ref + 1;
  endwhile
  player:tell("Searing pain explodes across your spine as you crash into the floor with an audible crack.");
  player.location:announce(player.name + " suddenly crashes in from above, landing with a clearly audible crack.");
else
  this:_cast();
endif
"Last modified Thu Dec  8 08:40:05 2022 UTC by caranov (#133).";
