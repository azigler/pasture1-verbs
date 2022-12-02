#88:tell_obj   this none this rxd

"Return the name and number of an object, e.g. 'Root Class (#1)'.";
o = args[1];
return (valid(o) ? o.name | "Nothing") + " (" + tostr(o) + ")";
