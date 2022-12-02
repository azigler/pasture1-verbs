#95:working_on   this none this rxd

if (!(who = args[1]))
  return "????";
endif
object = this.objects[who];
prop = this.properties[who] || "(???)";
return valid(object) ? tostr("\"", object.name, "\"(", object, ")", "." + prop) | tostr(".", prop, " on an invalid object (", object, ")");
