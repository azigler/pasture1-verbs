#37:delete   this none this rxd

":delete(string[,n]) deletes any <string,something> pair from the tree starting at node \" \"+string[1..n], n defaulting to 0 (root node)";
"Returns {something} if such a pair existed, otherwise returns 0";
"If that node is not the root node and ends up containing only one string and no subnodes, we kill it and return {something,string2,something2} where <string2,something2> is the remaining pair.";
if (!($perm_utils:controls(caller_perms(), this) || caller == this))
  return E_PERM;
endif
{search, ?sofar = 0} = args;
rest = search;
prefix = search[1..sofar];
rest[1..sofar] = "";
info = this.(" " + prefix);
if (i = search in info[3])
  previous = {info[this.data][i]};
  info[3] = listdelete(info[3], i);
  if (this.data > 3)
    info[this.data] = listdelete(info[this.data], i);
  endif
elseif (rest == info[1] || (index(rest, info[1]) != 1 || !index(info[2], search[d = sofar + length(info[1]) + 1])))
  "... hmm string isn't in here...";
  return 0;
elseif ((previous = this:delete(search, d)) && length(previous) > 1)
  i = index(info[2], search[d]);
  info[2][i..i] = "";
  info[3] = {previous[2], @info[3]};
  if (this.data > 3)
    info[this.data] = {previous[3], @info[this.data]};
  endif
  previous = previous[1..1];
else
  return previous;
endif
if (!prefix || length(info[3]) + length(info[2]) != 1)
  this:set_node(prefix, @info);
  return previous;
elseif (info[3])
  this:kill_node(prefix);
  return {@previous, info[3][1], info[this.data][1]};
else
  sub = this.(" " + (p = tostr(prefix, info[1], info[2])));
  this:kill_node(p);
  this:set_node(prefix, @listset(sub, tostr(info[1], info[2], sub[1]), 1));
  return previous;
endif
