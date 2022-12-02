#53:canonicalize_spaces   this none this rxd

name = args[1];
while (index(name, "  "))
  name = strsub(name, "  ", " ");
endwhile
return name;
