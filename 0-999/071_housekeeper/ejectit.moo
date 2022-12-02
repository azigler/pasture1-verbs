#71:ejectit   this none this rxd

"this:ejectit(object,room): Eject args[1] from args[2].  Callable only by housekeeper's quarters verbs.";
if (caller == this)
  args[2]:eject(args[1]);
endif
