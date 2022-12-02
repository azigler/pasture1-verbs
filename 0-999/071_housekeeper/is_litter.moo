#71:is_litter   this none this rxd

thingy = args[1];
for x in (this.litter)
  if ($object_utils:isa(thingy, x[1]) && !$object_utils:isa(thingy, x[2]))
    return 1;
  endif
endfor
return 0;
