#20:"capitalize capitalise"   this none this rxd

"capitalizes its argument.";
if ((string = args[1]) && (i = index("abcdefghijklmnopqrstuvwxyz", string[1], 1)))
  string[1] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"[i];
endif
return string;
