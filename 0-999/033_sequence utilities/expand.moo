#33:expand   this none this rxd

":expand(seq,eseq[,include=0])";
"eseq is assumed to be a finite sequence consisting of intervals ";
"[f1..a1-1],[f2..a2-1],...  We map each element i of seq to";
"  i               if               i < f1";
"  i+(a1-f1)       if         f1 <= i < f2-(a1-f1)";
"  i+(a1-f1+a2-f2) if f2-(a1-f1) <= i < f3-(a2-f2)-(a1-f1)";
"  ...";
"returning the resulting sequence if include=0,";
"returning the resulting sequence unioned with eseq if include=1;";
{old, insert, ?include = 0} = args;
exclude = !include;
if (!insert)
  return old;
elseif (length(insert) % 2 || insert[1] == $minint)
  return E_TYPE;
endif
olast = length(old);
ilast = length(insert);
"... find first o for which old[o] >= insert[1]...";
ifirst = insert[i = 1];
o = $list_utils:find_insert(old, ifirst - 1);
if (o > olast)
  return olast % 2 == exclude ? {@old, @insert} | old;
endif
new = old[1..o - 1];
oe = old[o];
diff = 0;
while (1)
  "INVARIANT: oe == old[o]+diff";
  "INVARIANT: oe >= ifirst == insert[i]";
  "... at this point we need to dispose of the interval ifirst..insert[i+1]";
  if (oe == ifirst)
    new = {@new, insert[i + (o % 2 == exclude)]};
    if (o >= olast)
      return olast % 2 == exclude ? {@new, @insert[i + 2..ilast]} | new;
    endif
    o = o + 1;
  else
    if (o % 2 != exclude)
      new = {@new, @insert[i..i + 1]};
    endif
  endif
  "... advance i...";
  diff = diff + insert[i + 1] - ifirst;
  if ((i = i + 2) > ilast)
    for oe in (old[o..olast])
      new = {@new, oe + diff};
    endfor
    return new;
  endif
  ifirst = insert[i];
  "... find next o for which old[o]+diff >= ifirst )...";
  while ((oe = old[o] + diff) < ifirst)
    new = {@new, oe};
    if (o >= olast)
      return olast % 2 == exclude ? {@new, @insert[i..ilast]} | new;
    endif
    o = o + 1;
  endwhile
endwhile
