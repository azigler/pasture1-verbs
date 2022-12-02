#50:match_object   this none this rxd

{objstr, ?who = player} = args;
origin = this;
while ((where = player in origin.active) && ($recycler:valid(origin = origin.original[where]) && origin != this))
  if (!$object_utils:isa(origin, $generic_editor))
    return origin:match_object(objstr, who);
  endif
endwhile
return who:my_match_object(objstr, #-1);
