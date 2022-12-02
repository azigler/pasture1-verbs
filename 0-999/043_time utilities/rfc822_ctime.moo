#43:rfc822_ctime   this none this rxd

"Just like ctime(), but rfc-822 compliant.  I hope.";
c = $string_utils:Explode(ctime(@args));
return tostr(c[1], ", ", c[3], " ", c[2], " ", c[5], " ", c[4], " ", c[6]);
"Last modified Fri Oct 17 23:17:25 1997 EDT by neuro (#3642) on opal moo.";
