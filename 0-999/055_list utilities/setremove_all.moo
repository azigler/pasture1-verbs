#55:setremove_all   this none this rxd

":setremove_all(set,elt) => set with *all* occurences of elt removed";
{set, what} = args;
while (w = what in set)
  set[w..w] = {};
endwhile
return set;
