#55:assoc   this none this rxd

"assoc(target,list[,index]) returns the first element of `list' whose own index-th element is target.  Index defaults to 1.";
"returns {} if no such element is found";
{target, thelist, ?indx = 1} = args;
for t in (thelist)
  if (typeof(t) == LIST && `t[indx] == target ! E_RANGE => 0')
    return t;
  endif
endfor
return {};
