#3:look_self   this none this rxd

{?brief = 0} = args;
player:tell(this:title());
if (!brief)
  pass();
endif
this:tell_contents(setremove(this:contents(), player), this.ctype);
