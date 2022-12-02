#37:insert   this none this rxd

":insert([n,]string,datum) -- inserts <string,datum> correspondence into tree starting at node \" \"+string[1..n], n defaulting to 0 (root node).";
"Assumes length(string) >= n";
"Returns {old_datum} (or 1) if there was a <string,old_datum> correspondence there before, otherwise returns 0";
if (!($perm_utils:controls(caller_perms(), this) || caller == this))
  return E_PERM;
endif
has_datum = this.data > 3;
if (typeof(sofar = args[1]) == INT)
  search = args[2];
  datum = has_datum ? args[3] | 0;
else
  search = sofar;
  sofar = 0;
  datum = has_datum ? args[2] | 0;
endif
prefix = search[1..sofar];
info = this.(" " + prefix);
if (i = search in info[3])
  "... exact match ...";
  if (has_datum)
    previous = {info[this.data][i]};
    info[this.data][i] = datum;
    this:set_node(prefix, @info);
    return previous;
  else
    return 1;
  endif
endif
rest = search;
rest[1..sofar] = "";
if (index(rest, info[1]) != 1)
  "... find where new string disagrees with common portion...";
  c = $string_utils:common(rest, info[1]) + 1;
  "... make a new node with a shorter common portion....";
  this:make_node(prefix + info[1][1..c], @listset(info, info[1][c + 1..$], 1));
  this:set_node(prefix, info[1][1..c - 1], info[1][c], {search}, @has_datum ? {{datum}} | {});
  return 0;
elseif (rest == info[1])
  ".. new string == common portion, insert...";
  info[3] = {@info[3], search};
  if (has_datum)
    info[this.data] = {@info[this.data], datum};
  endif
  this:set_node(prefix, @info);
  return 0;
elseif (index(info[2], search[nsofar = sofar + length(info[1]) + 1]))
  "... new string matches pre-existing continuation. insert in subnode....";
  return this:insert(nsofar, search, datum);
else
  "... new string may blow away one of the exact matches (i.e., matches one of them up to the first character beyond the common portion) in which case we need to create a new subnode....";
  s = search[1..nsofar];
  for m in (info[3])
    if (index(m, s) == 1)
      i = m in info[3];
      "... we know m != search ...";
      "... string m has been blown away.  create new node ...";
      cbegin = cafter = length(s) + 1;
      cend = $string_utils:common(search, m);
      this:make_node(s, m[cbegin..cend], "", {search, m}, @has_datum ? {{datum, info[this.data][i]}} | {});
      this:set_node(prefix, info[1], info[2] + s[nsofar], listdelete(info[3], i), @has_datum ? {listdelete(info[this.data], i)} | {});
      return 0;
    endif
  endfor
  "... new string hasn't blown away any of the exact matches, insert it as a new exact match...";
  info[3] = {search, @info[3]};
  if (has_datum)
    info[this.data] = {datum, @info[this.data]};
  endif
  this:set_node(prefix, @info);
  return 0;
endif
