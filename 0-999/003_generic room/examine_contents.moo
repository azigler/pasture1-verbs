#3:examine_contents   this none this rxd

"examine_contents(who)";
if (caller == this)
  this:tell_contents(this.contents, this.ctype);
endif
