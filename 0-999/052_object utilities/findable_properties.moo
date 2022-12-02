#52:findable_properties   this none this rxd

"findable_properties(object)";
"Return a list of properties on those members of object's ancestor list that are readable or are owned by the caller (or all properties if the caller is a wizard).";
what = args[1];
props = {};
who = caller_perms();
while (what != $nothing)
  if (what.r || who == what.owner || who.wizard)
    props = {@properties(what), @props};
  endif
  what = parent(what);
endwhile
return props;
