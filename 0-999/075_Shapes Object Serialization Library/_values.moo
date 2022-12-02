#75:_values   this none this xd

{o} = args;
x = {};
for t in ({o, @ancestors(o)})
  this:_suspend_if_necessary();
  y = {};
  for z in (properties(t))
    this:_suspend_if_necessary();
    y = {z, @y};
  endfor
  x = {@y, @x};
endfor
x = {"name", "owner", "location", "programmer", "wizard", "r", "w", "f", "a", @x};
return x;
