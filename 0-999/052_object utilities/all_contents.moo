#52:all_contents   this none this rxd

"all_contents(object)";
"Return a list of all objects contained (at some level) by object.";
for y in (res = args[1].contents)
  y.contents && (res = {@res, @this:all_contents(y)});
endfor
return res;
