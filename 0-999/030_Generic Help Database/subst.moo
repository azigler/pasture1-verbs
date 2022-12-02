#30:subst   this none this rxd

"{\"*subst*\", @text} => text with the following substitutions:";
"  \"...%[expr]....\" => \"...\"+value of expr (assumed to be a string)+\"....\"";
"  \"%;expr\"         => @(value of expr (assumed to be a list of strings))";
newlines = {};
for old in (args[1])
  new = "";
  bomb = 0;
  while ((prcnt = index(old, "%")) && prcnt < length(old))
    new = new + old[1..prcnt - 1];
    code = old[prcnt + 1];
    old = old[prcnt + 2..$];
    if (code == "[")
      prog = "";
      while ((b = index(old + "]", "]")) > (p = index(old + "%", "%")))
        prog = prog + old[1..p - 1] + old[p + 1];
        old = old[p + 2..$];
      endwhile
      prog = prog + old[1..b - 1];
      old = old[b + 1..$];
      value = $no_one:eval_d(prog);
      if (value[1])
        new = tostr(new, value[2]);
      else
        new = tostr(new, toliteral(value[2]));
        bomb = 1;
      endif
    elseif (code != ";" || new)
      new = new + "%" + code;
    else
      value = $no_one:eval_d(old);
      if (value[1] && typeof(r = value[2]) == LIST)
        newlines = {@newlines, @r[1..$ - 1]};
        new = tostr(r[$]);
      else
        new = tostr(new, toliteral(value[2]));
        bomb = 1;
      endif
      old = "";
    endif
  endwhile
  if (bomb)
    newlines = {@newlines, new + old, tostr("@@@ Helpfile alert:  Previous line is messed up; notify ", this.owner.wizard ? "" | tostr(this.owner.name, " (", this.owner, ") or "), "a wizard. @@@")};
  else
    newlines = {@newlines, new + old};
  endif
endfor
return newlines;
