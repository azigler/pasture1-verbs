#13:_split   this none this rxd

"_split(home, height,lmax,ltree[,@rtrees]}) => {ltree,[mtree,]@rtrees}";
"ltree is split after the lmax'th leaf, the righthand portion grafted onto the leftmost of the rtrees, if possible.  Otherwise we create a new tree mtree, stealing from rtrees[1] if necessary.";
"Assumes 1<=lmax<ltree[2]";
if (caller != this)
  return E_PERM;
endif
{home, height, lmax, ltree, @rtrees} = args;
llen = length(lkids = home:_get(ltree[1])[2]);
rlen = length(rkids = rtrees ? home:_get(rtrees[1][1])[2] | {});
if (height)
  ik = this:_listfind_nth(lkids, lmax);
  if (ik[2])
    llast = ik[1];
    m = this:_split(home, height - 1, ik[2], lkids[llast], @lkids[llast + 1..llen], @rkids);
    lkids[llast] = m[1];
    mkids = listdelete(m, 1);
  else
    llast = ik[1] - 1;
    mkids = {@lkids[ik[1]..llen], @rkids};
  endif
  home:_put(ltree[1], height, lkids[1..llast]);
  mlen = length(mkids);
  if ((mlen - rlen) * 2 >= this.maxfanout || !rtrees)
    "...residue left over from splitting ltree can stand by itself...";
    return {listset(ltree, lmax, 2), {home:_make(height, mkids[1..mlen - rlen]), ltree[2] - lmax, mkids[1][3]}, @rtrees};
  elseif (mlen <= this.maxfanout)
    "...residue left over from splitting ltree fits in rtrees[1]...";
    home:_put(rtrees[1][1], height, mkids);
    rtrees[1][2] = ltree[2] - lmax + rtrees[1][2];
    rtrees[1][3] = mkids[1][3];
    return {listset(ltree, lmax, 2), @rtrees};
  else
    "...need to steal from rtrees[1]...";
    if (llast < llen)
      msize = ltree[2] - lmax;
      R = mlen - rlen + 1;
    else
      msize = 0;
      R = 1;
    endif
    for k in (mkids[R..mlen / 2])
      msize = msize + k[2];
    endfor
    home:_put(rtrees[1][1], height, mkids[mlen / 2 + 1..mlen]);
    rtrees[1][2] = rtrees[1][2] + ltree[2] - (lmax + msize);
    rtrees[1][3] = mkids[mlen / 2 + 1][3];
    return {listset(ltree, lmax, 2), {home:_make(height, mkids[1..mlen / 2]), msize, mkids[1][3]}, @rtrees};
  endif
else
  home:_put(ltree[1], 0, lkids[1..lmax]);
  if ((llen - lmax) * 2 >= this.maxfanout || !rtrees)
    "...residue left over from splitting ltree can stand by itself...";
    return {listset(ltree, lmax, 2), {home:_make(0, lkids[lmax + 1..llen]), llen - lmax, home:_ord(lkids[lmax + 1])}, @rtrees};
  elseif ((mlen = rlen + llen - lmax) <= this.maxfanout)
    "...residue left over from splitting ltree fits in rtrees[1]...";
    home:_put(rtrees[1][1], 0, {@lkids[lmax + 1..llen], @rkids});
    rtrees[1][2] = mlen;
    rtrees[1][3] = home:_ord(lkids[lmax + 1]);
    return {listset(ltree, lmax, 2), @rtrees};
  else
    "...need to steal from rtrees[1]...";
    home:_put(rtrees[1][1], 0, rkids[(R = (rlen - llen + lmax) / 2) + 1..rlen]);
    rtrees[1][2] = (mlen + 1) / 2;
    rtrees[1][3] = home:_ord(rkids[R + 1]);
    return {listset(ltree, lmax, 2), {home:_make(0, {@lkids[lmax + 1..llen], @rkids[1..R]}), mlen / 2, home:_ord(lkids[lmax + 1])}, @rtrees};
  endif
endif
