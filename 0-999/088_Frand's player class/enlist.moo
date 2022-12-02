#88:enlist   this none this rxd

"'enlist (<x>)' - If x is a list, just return it; otherwise, return {x}. The purpose here is to turn message strings into lists, so that lines can be added. It is not guaranteed to work for non-string non-lists.";
x = args[1];
if (!x)
  return {};
elseif (typeof(x) == LIST)
  return x;
else
  return {x};
endif
