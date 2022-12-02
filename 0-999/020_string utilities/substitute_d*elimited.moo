#20:substitute_d*elimited   none none none rxd

"subst(string,{{redex1,repl1},{redex2,repl2},{redex3,repl3}...}[,case])";
"Just like :substitute() but it uses index_delimited() instead of index()";
{ostr, subs, ?case = 0} = args;
if (typeof(ostr) != STR)
  return ostr;
endif
len = length(ostr);
" - - - find the first instance of each substitution - -";
indices = {};
substs = {};
for s in (subs)
  if (i = this:index_delimited(ostr, s[1], case))
    fi = $list_utils:find_insert(indices, i = i - len) - 1;
    while (fi && (indices[fi] == i && length(substs[fi][1]) < length(s[1])))
      "...give preference to longer redexes...";
      fi = fi - 1;
    endwhile
    indices = listappend(indices, i, fi);
    substs = listappend(substs, s, fi);
  endif
endfor
"- - - - - perform substitutions - ";
nstr = "";
while (substs)
  ind = len + indices[1];
  sub = substs[1];
  indices = listdelete(indices, 1);
  substs = listdelete(substs, 1);
  if (ind > 0)
    nstr = nstr + ostr[1..ind - 1] + sub[2];
    ostr = ostr[ind + length(sub[1])..len];
    len = length(ostr);
  endif
  if (next = this:index_delimited(ostr, sub[1], case))
    fi = $list_utils:find_insert(indices, next = next - len) - 1;
    while (fi && (indices[fi] == next && length(substs[fi][1]) < length(sub[1])))
      "...give preference to longer redexes...";
      fi = fi - 1;
    endwhile
    indices = listappend(indices, next, fi);
    substs = listappend(substs, sub, fi);
  endif
endwhile
return nstr + ostr;
