#69:match_error   this none this rxd

"match_error -- searches for tostr(E_WHATEVER) in a string, returning the ERR, returns -1 if no error string is found.";
string = args[1];
for e in (this.all_errors)
  if (index(string, tostr(e)))
    return e;
  endif
endfor
return -1;
