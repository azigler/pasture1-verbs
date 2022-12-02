#59:verb_documentation   this none this rxd

":verb_documentation([object,verbname]) => documentation at beginning of verb code, if any";
"default is the calling verb";
set_task_perms(caller_perms());
c = callers()[1];
{?object = c[4], ?vname = c[2]} = args;
try
  code = verb_code(object, vname);
except error (ANY)
  return error[2];
endtry
doc = {};
for line in (code)
  if (match(line, "^\"%([^\\\"]%|\\.%)*\";$"))
    "... now that we're sure `line' is just a string, eval() is safe...";
    doc = {@doc, $no_one:eval("; return " + line)[2]};
  else
    return doc;
  endif
endfor
return doc;
