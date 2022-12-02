#26:round   this none this rxd

"Usage: round(INT number, INT round)";
"Rounds 'number' off to the nearest multiple of 'round'.";
"Rounds UP numbers exactly half way in between two round possibilities.";
{what, round} = args;
low = what / round * round;
return what < low + round / 2 ? low | low + round;
