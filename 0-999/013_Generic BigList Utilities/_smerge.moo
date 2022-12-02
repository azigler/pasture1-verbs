#13:_smerge   this none this rxd

"_smerge(home, height, ltree, rtree) =>{ltree[,rtree]}";
"assumes ltree and rtree are at the given height.";
"merges the trees if the combined number of children is <= maxfanout";
"otherwise returns two trees where ltree is guaranteed minfanout children and rtree is guaranteed the minimum of minfanout and however many children it started with.";
if (caller != this)
  return E_PERM;
endif
{home, height, ltree, rtree} = args;
llen = length(lkids = home:_get(ltree[1])[2]);
rlen = length(rkids = home:_get(rtree[1])[2]);
if (height)
  m = this:_smerge(home, height - 1, lkids[llen], rkids[1]);
  mlen = length(mkids = {@listdelete(lkids, llen), @m, @listdelete(rkids, 1)});
  if (mlen <= this.maxfanout)
    home:_put(ltree[1], height, mkids);
    home:_kill(rtree[1]);
    ltree[2] = ltree[2] + rtree[2];
    return {ltree};
  else
    S = max(llen - 1, (mlen + 1) / 2);
    home:_put(ltree[1], height, mkids[1..S]);
    home:_put(rtree[1], height, mkids[S + 1..$]);
    xfer = -lkids[llen][2];
    for k in (mkids[llen..S])
      xfer = xfer + k[2];
    endfor
    ltree[2] = ltree[2] + xfer;
    rtree[2] = rtree[2] - xfer;
    rtree[3] = mkids[S + 1][3];
    return {ltree, rtree};
  endif
elseif (llen * 2 >= this.maxfanout)
  return {ltree, rtree};
elseif (this.maxfanout < llen + rlen)
  T = (rlen - llen + 1) / 2;
  home:_put(ltree[1], 0, {@lkids, @rkids[1..T]});
  home:_put(rtree[1], 0, rkids[T + 1..rlen]);
  ltree[2] = ltree[2] + T;
  rtree[2] = rtree[2] - T;
  rtree[3] = home:_ord(rkids[T + 1]);
  return {ltree, rtree};
else
  home:_put(ltree[1], 0, {@lkids, @rkids});
  home:_kill(rtree[1]);
  ltree[2] = ltree[2] + rtree[2];
  return {ltree};
endif
