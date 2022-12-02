#33:_union   this none this rxd

":_union(seq,seq,...)";
"assumes all seqs are nonempty and that there are at least 2";
nargs = length(args);
"args  -- list of sequences.";
"nexts -- nexts[i] is the index in args[i] of the start of the first";
"         interval not yet incorporated in the return sequence.";
"heap  -- a binary tree of indices into args/nexts represented as a list where";
"         heap[1] is the root and the left and right children of heap[i]";
"         are heap[2*i] and heap[2*i+1] respectively.  ";
"         Parent index h is <= both children in the sense of args[h][nexts[h]].";
"         heap[i]==0 indicates a nonexistant child; we fill out the array with";
"         zeros so that length(heap)>2*length(args).";
"...initialize heap...";
heap = {0, 0, 0, 0, 0};
nexts = {1, 1};
hlen2 = 2;
while (hlen2 < nargs)
  nexts = {@nexts, @nexts};
  heap = {@heap, @heap};
  hlen2 = hlen2 * 2;
endwhile
for n in [-nargs..-1]
  s1 = args[i = -n][1];
  while ((hleft = heap[2 * i]) && s1 > (m = min(la = args[hleft][1], (hright = heap[2 * i + 1]) ? args[hright][1] | $maxint)))
    if (m == la)
      heap[i] = hleft;
      i = 2 * i;
    else
      heap[i] = hright;
      i = 2 * i + 1;
    endif
  endwhile
  heap[i] = -n;
endfor
"...";
"...find first interval...";
h = heap[1];
rseq = {args[h][1]};
if (length(args[h]) < 2)
  return rseq;
endif
current_end = args[h][2];
nexts[h] = 3;
"...";
while (1)
  if (length(args[h]) >= nexts[h])
    "...this sequence has some more intervals in it...";
  else
    "...no more intevals left in this sequence, grab another...";
    h = heap[1] = heap[nargs];
    heap[nargs] = 0;
    if ((nargs = nargs - 1) > 1)
    elseif (args[h][nexts[h]] > current_end)
      return {@rseq, current_end, @args[h][nexts[h]..$]};
    elseif ((i = $list_utils:find_insert(args[h], current_end)) % 2)
      return {@rseq, current_end, @args[h][i..$]};
    else
      return {@rseq, @args[h][i..$]};
    endif
  endif
  "...";
  "...sink the top sequence...";
  i = 1;
  first = args[h][nexts[h]];
  while ((hleft = heap[2 * i]) && first > (m = min(la = args[hleft][nexts[hleft]], (hright = heap[2 * i + 1]) ? args[hright][nexts[hright]] | $maxint)))
    if (m == la)
      heap[i] = hleft;
      i = 2 * i;
    else
      heap[i] = hright;
      i = 2 * i + 1;
    endif
  endwhile
  heap[i] = h;
  "...";
  "...check new top sequence ...";
  if (args[h = heap[1]][nexts[h]] > current_end)
    "...hey, a new interval! ...";
    rseq = {@rseq, current_end, args[h][nexts[h]]};
    if (length(args[h]) <= nexts[h])
      return rseq;
    endif
    current_end = args[h][nexts[h] + 1];
    nexts[h] = nexts[h] + 2;
  else
    "...first interval overlaps with current one ...";
    i = $list_utils:find_insert(args[h], current_end);
    if (i % 2)
      nexts[h] = i;
    elseif (i > length(args[h]))
      return rseq;
    else
      current_end = args[h][i];
      nexts[h] = i + 1;
    endif
  endif
endwhile
