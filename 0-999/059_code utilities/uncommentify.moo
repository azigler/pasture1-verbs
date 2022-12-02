#59:uncommentify   this none this rxd

" Usage:  uncommentify(lines)";
"";
" Given lines of comment code, translate them into text and return the list.";
set_task_perms($no_one);
{lines} = args;
out = {};
for line in (lines)
  if (match(line, "^\"%([^\\\"]%|\\.%)*\";$"))
    out = {@out, eval("return " + line)[2]};
  else
    return E_INVARG;
  endif
endfor
return out;
