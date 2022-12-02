#49:working_on   this none this rxd

if (!(fuckup = this:ok(who = args[1])))
  return fuckup;
else
  object = this.objects[who];
  verbname = this.verbnames[who];
  if (typeof(verbname) == LIST)
    return tostr(object, ":", verbname[1], " (", $string_utils:from_list(listdelete(verbname, 1), " "), ")");
  else
    return tostr(object, ":", this:verb_name(object, verbname), " (", this:verb_args(object, verbname), ")");
  endif
endif
"return this:ok(who = args[1]) && tostr(this.objects[who]) + \":\" + this.verbnames[who];";
