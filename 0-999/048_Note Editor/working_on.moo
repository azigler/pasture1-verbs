#48:working_on   this none this rxd

if (!(who = args[1]))
  return "????";
endif
spec = this.objects[who];
if (typeof(spec) == LIST)
  object = spec[1];
  prop = spec[2];
else
  object = spec;
  prop = 0;
endif
return valid(object) ? tostr("\"", object.name, "\"(", object, ")", prop ? "." + prop | "") | tostr(prop ? "." + prop + " on " | "", "invalid object (", object, ")");
