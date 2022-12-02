#50:parse_range   this none this rxd

"parse_range(who,default,@args) => {from to rest}";
numargs = length(args);
if (!(fuckup = this:ok(who = args[1])))
  return fuckup;
elseif (!(last = length(this.texts[who])))
  return this:no_text_msg();
endif
default = args[2];
r = 0;
while (default && LIST != typeof(r = this:parse_range(who, {}, default[1])))
  default = listdelete(default, 1);
endwhile
if (typeof(r) == LIST)
  from = r[1];
  to = r[2];
else
  from = to = 0;
endif
saw_from_to = 0;
not_done = 1;
a = 2;
while ((a = a + 1) <= numargs && not_done)
  if (args[a] == "from")
    if (a == numargs || !(from = this:parse_number(who, args[a = a + 1], 0)))
      return "from ?";
    endif
    saw_from_to = 1;
  elseif (args[a] == "to")
    if (a == numargs || !(to = this:parse_number(who, args[a = a + 1], 1)))
      return "to ?";
    endif
    saw_from_to = 1;
  elseif (saw_from_to)
    a = a - 1;
    not_done = 0;
  elseif (i = index(args[a], "-"))
    from = this:parse_number(who, args[a][1..i - 1], 0);
    to = this:parse_number(who, args[a][i + 1..$], 1);
    not_done = 0;
  elseif (f = this:parse_number(who, args[a], 0))
    from = f;
    if (a == numargs || !(to = this:parse_number(who, args[a + 1], 1)))
      to = from;
    else
      a = a + 1;
    endif
    not_done = 0;
  else
    a = a - 1;
    not_done = 0;
  endif
endwhile
if (from < 1)
  return tostr("from ", from, "?  (out of range)");
elseif (to > last)
  return tostr("to ", to, "?  (out of range)");
elseif (from > to)
  return tostr("from ", from, " to ", to, "?  (backwards range)");
else
  return {from, to, $string_utils:from_list(args[a..numargs], " ")};
endif
