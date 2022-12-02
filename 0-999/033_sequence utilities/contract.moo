#33:contract   this none this rxd

":contract(seq,cseq)";
"cseq is assumed to be a finite sequence consisting of intervals ";
"[f1..a1-1],[f2..a2-1],...  From seq, we remove any elements that ";
"are in those ranges and map each remaining element i to";
"  i               if       i < f1";
"  i-(a1-f1)       if a1 <= i < f2";
"  i-(a1-f1+a2-f2) if a2 <= i < f3 ...";
"returning the resulting sequence.";
"";
"For any finite sequence cseq, the following always holds:";
"  :contract(:expand(seq,cseq,include),cseq)==seq";
{old, removed} = args;
if (!removed)
  return old;
elseif ((rlen = length(removed)) % 2 || removed[1] == $minint)
  return E_TYPE;
endif
rfirst = removed[1];
ofirst = $list_utils:find_insert(old, rfirst - 1);
new = old[1..ofirst - 1];
diff = 0;
rafter = removed[r = 2];
for o in [ofirst..olast = length(old)]
  while (old[o] > rafter)
    if ((o - ofirst) % 2)
      new = {@new, rfirst - diff};
      ofirst = o;
    endif
    diff = diff + rafter - rfirst;
    if (r >= rlen)
      for oe in (old[o..olast])
        new = {@new, oe - diff};
      endfor
      return new;
    endif
    rfirst = removed[r + 1];
    rafter = removed[r = r + 2];
  endwhile
  if (old[o] < rfirst)
    new = {@new, old[o] - diff};
    ofirst = o + 1;
  endif
endfor
return (olast - ofirst) % 2 ? new | {@new, rfirst - diff};
