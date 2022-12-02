#1:match   this none this rxd

c = this:contents();
return $string_utils:match(args[1], c, "name", c, "aliases");
