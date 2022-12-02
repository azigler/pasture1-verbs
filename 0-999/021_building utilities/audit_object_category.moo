#21:audit_object_category   this none this rxd

if (is_player(what = args[1]))
  return "P";
endif
while (valid(what))
  if (i = what in this.classes)
    return this.class_string[i];
  endif
  what = parent(what);
endwhile
return " ";
