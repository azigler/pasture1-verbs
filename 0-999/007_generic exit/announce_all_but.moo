#7:announce_all_but   this none this rxd

"This is intended to be called only by exits, for announcing various oxxx messages.  First argument is room to announce in.  Second argument is as in $room:announce_all_but's first arg, who not to announce to.  Rest args are what to say.  If the final arg is a list, prepends all the other rest args to the first line and emits the lines separately.";
where = args[1];
whobut = args[2];
last = args[$];
if (typeof(last) == LIST)
  where:announce_all_but(whobut, @args[3..$ - 1], last[1]);
  for line in (last[2..$])
    where:announce_all_but(whobut, line);
  endfor
else
  where:announce_all_but(@args[3..$]);
endif
