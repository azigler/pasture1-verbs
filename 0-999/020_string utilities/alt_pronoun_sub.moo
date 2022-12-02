#20:alt_pronoun_sub   none none none rxd

"Pronoun (and other things) substitution. See 'help pronouns' for details.";
"syntax:  $string_utils:pronoun_sub(text[,who[,thing[,location]]])";
"%s,%o,%p,%q,%r    => <who>'s pronouns.  <who> defaults to player.";
"%n,%d,%i,%t,%l,%% => <who>, dobj, iobj, this, <who>.location and %";
"%S,%O,%P,%Q,%R, %N,%D,%I,%T,%L have corresponding capitalized substitutions.";
" %[#n], %[#d], ...  =>  <who>, dobj, etc.'s object number";
"%(foo) => <who>.foo and %(Foo) => <who>.foo capitalized. %[dfoo] => dobj.foo, etc..";
"%<foo> -> whatever <who> does when normal people foo. This is determined by calling :verb_sub() on the <who>.";
"%<d:foo> -> whatever <dobj> does when normal people foo.";
set_task_perms($no_one);
{string, ?who = player, ?thing = caller, ?where = $nothing} = args;
where = valid(who) ? who.location | where;
if (typeof(string) == LIST)
  plines = {};
  for line in (string)
    plines = {@plines, this:(verb)(line, who, thing, where)};
  endfor
  return plines;
endif
old = tostr(string);
new = "";
objspec = "nditl";
objects = {who, dobj, iobj, thing, where};
prnspec = "sopqrSOPQR";
prprops = {"ps", "po", "pp", "pq", "pr", "Ps", "Po", "Pp", "Pq", "Pr"};
oldlen = length(old);
while ((prcnt = index(old, "%")) && prcnt < oldlen)
  s = old[k = prcnt + 1];
  if (s == "<" && (gt = index(old[k + 2..$], ">")))
    "handling %<verb> ";
    gt = gt + k + 1;
    vb = old[k + 1..gt - 1];
    vbs = who;
    if (length(vb) > 2 && vb[2] == ":")
      " %<d:verb>";
      vbs = objects[index(objspec, vb[1]) || 1];
      vb = vb[3..$];
    endif
    vb = $object_utils:has_verb(vbs, "verb_sub") ? vbs:verb_sub(vb) | this:(verb)(vb, vbs);
    new = new + old[1..prcnt - 1] + vb;
    k = gt;
  else
    cp_args = {};
    if (brace = index("([", s))
      if (!(w = index(old[k + 1..oldlen], ")]"[brace])))
        return new + old;
      else
        p = old[prcnt + 2..(k = k + w) - 1];
        if (brace == 1)
          "%(property)";
          cp_args = {who, p};
        elseif (p[1] == "#")
          "%[#n] => object number";
          s = (o = index(objspec, p[2])) ? tostr(objects[o]) | "[" + p + "]";
        elseif (!(o = index(objspec, p[1])))
          s = "[" + p + "]";
        else
          " %[dproperty] ";
          cp_args = {objects[o], p[2..w - 1], strcmp(p[1], "a") < 0};
        endif
      endif
    elseif (o = index(objspec, s))
      cp_args = {objects[o], "", strcmp(s, "a") < 0};
    elseif (w = index(prnspec, s, 1))
      cp_args = {who, prprops[w]};
    elseif (s == "#")
      s = tostr(who);
    elseif (s != "%")
      s = "%" + s;
    endif
    new = new + old[1..prcnt - 1] + (!cp_args ? s | (typeof(sub = $string_utils:_cap_property(@cp_args)) != ERR ? sub | "%(" + tostr(sub) + ")"));
  endif
  old = old[k + 1..oldlen];
  oldlen = oldlen - k;
endwhile
return new + old;
