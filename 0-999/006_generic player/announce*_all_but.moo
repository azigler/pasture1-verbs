#6:announce*_all_but   this none this rxd

return this.location:(verb)(@args);
"temporarily let player:announce be noisy to player";
if (verb == "announce_all_but")
  if (this in args[1])
    return;
  endif
  args = args[2..$];
endif
this:tell("(from within you) ", @args);
