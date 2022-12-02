#59:corify_object   this none this rxd

":corify_object(object)  => string representing object";
"  usually just returns tostr(object), but in the case of objects that have";
"  corresponding #0 properties, return the appropriate $-string.";
object = args[1];
"Just in case #0 is !r on some idiot core.";
for p in (`properties(#0) ! ANY => {}')
  "And if for some reason, some #0 prop is !r.";
  if (`#0.(p) ! ANY' == object)
    return "$" + p;
  elseif (typeof(`#0.(p) ! ANY') == MAP)
    for value, key in (#0.(p))
      if (value == object)
        return tostr("$", p, "[\"", key, "\"]");
      endif
    endfor
  endif
endfor
return tostr(object);
