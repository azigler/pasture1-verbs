#71:is_cleaning   this none this rxd

"return a string status if the hosuekeeper is cleaning this object";
cleanable = args[1];
info = this:is_object_cleaned(cleanable);
if (info == 0)
  return tostr(cleanable.name, " is not cleaned by the ", this.name, ".");
else
  return tostr(cleanable.name, " is kept tidy at ", $string_utils:nn(info[1]), " at the request of ", $string_utils:nn(info[2]), ".");
endif
