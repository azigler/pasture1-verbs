#37:"find find_key"   this none this rxd

"find(string[,n]) => datum corresponding to string with the search starting at node \" \"+string[1..n], n defaults to 0 (root node), $ambiguous_match or $failed_match";
"find_key(string[,n]) is like :find but returns the full string key rather than the associated datum.  Note that if several string keys present in the db share a common prefix, :find_key(prefix) will return $ambiguous_match, but if there is a unique datum associated with all of these strings :find(prefix) will return it rather than $ambiguous_match.";
"Assumes n<=length(string)";
{search, ?sofar = 0} = args;
rest = search;
prefix = search[1..sofar];
rest[1..sofar] = "";
info = this.(" " + prefix);
data = verb == "find" ? this.data | 3;
if (i = search in info[3])
  "...exact match for one of the strings in this node...";
  return info[data][i];
elseif (index(info[1], rest) == 1)
  "...ambiguous iff there's more than one object represented in this node..";
  return this:_only(prefix, data);
elseif (index(rest, info[1]) != 1)
  "...search string doesn't agree with common portion...";
  return $failed_match;
elseif (index(info[2], search[nsofar = sofar + length(info[1]) + 1]))
  "...search string follows one of continuations leading to other nodes...";
  return this:(verb)(search, nsofar);
else
  "...search string may partially match one of the strings in this node...";
  for i in [1..length(exacts = info[3])]
    if (index(exacts[i], search) == 1)
      return info[data][i];
    endif
  endfor
  return $failed_match;
endif
