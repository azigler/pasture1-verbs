#20:names_of   this none this rxd

"Return a string of the names and object numbers of the objects in a list.";
line = "";
for item in (args[1])
  if (typeof(item) == OBJ && valid(item))
    line = line + item.name + "(" + tostr(item) + ")   ";
  endif
endfor
return $string_utils:trimr(line);
