#43:dst_midnight   this none this rxd

"Takes a time that is midnight PST and converts it to the nearest PDT midnight time if it's during that part of the year where we use PDT.";
time = args[1];
return time - 3600 * ((toint(ctime(time)[12..13]) + 12) % 24 - 12);
