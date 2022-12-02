#5:moveto   this none this rxd

where = args[1];
"if (!valid(where) || this:is_unlocked_for(where))";
if (this:is_unlocked_for(where))
  pass(where);
endif
