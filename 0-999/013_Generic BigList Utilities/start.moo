#13:start   this none this rxd

":start(tree,first,last) => {list of leaf nodes, @handle}";
"handle is of the form {{node,next,size}...}";
if (tree = args[1])
  before = max(0, args[2] - 1);
  howmany = min(args[3], tree[2]) - before;
  if (howmany <= 0)
    return {};
  else
    spine = {};
    for h in [1..caller:_get(tree[1])[1]]
      ik = this:_listfind_nth(kids = caller:_get(tree[1])[2], before);
      newh = kids[ik[1]][2] - ik[2];
      if (newh < howmany)
        spine = {{tree[1], ik[1] + 1, howmany - newh}, @spine};
        howmany = newh;
      endif
      tree = kids[ik[1]];
      before = ik[2];
    endfor
    return {caller:_get(tree[1])[2][before + 1..before + howmany], @spine};
  endif
else
  return {};
endif
