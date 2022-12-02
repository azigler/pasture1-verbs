#13:next   this none this rxd

":next(@handle) => {list of more leaf nodes, @newhandle}";
if (args)
  spine = listdelete(args, 1);
  node = args[1][1];
  n = args[1][2];
  size = args[1][3];
  for h in [1..caller:_get(node)[1]]
    nnode = caller:_get(node)[2][n];
    if (size > nnode[2])
      spine = {{node, n + 1, size - nnode[2]}, @spine};
      size = nnode[2];
    endif
    n = 1;
    node = nnode[1];
  endfor
  test = caller:_get(node);
  return {test[2][n..size], @spine};
else
  return {};
endif
