#35:fixpos   this none this rxd

"This is horribly dwimmy.  E.g. %x's gets turned into your, %X's gets turned into Your, and %X'S gets turned into YOUR. --Nosredna";
upper = $string_utils:uppercase(args[2]);
allupper = upper + "'S";
upper = upper + "'s";
lower = $string_utils:lowercase(args[2]) + "'s";
return strsub(strsub(strsub(args[1], lower, "your", 1), upper, "Your", 1), allupper, "YOUR", 1);
