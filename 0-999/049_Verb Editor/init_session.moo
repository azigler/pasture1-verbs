#49:init_session   this none this rxd

{who, object, vname, vcode} = args;
if (this:ok(who))
  this:load(who, vcode);
  this.verbnames[who] = vname;
  this.objects[who] = object;
  this.active[who]:tell("Now editing ", this:working_on(who), ".");
  "this.active[who]:tell(\"Now editing \", object, \":\", vname, \".\");";
endif
