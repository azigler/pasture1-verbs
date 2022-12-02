#3:match   this none this rxd

target = {@this:contents(), @this:exits()};
return $string_utils:match(args[1], target, "name", target, "aliases");
