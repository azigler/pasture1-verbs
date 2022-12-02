#69:toerr   this none this rxd

"toerr -- given a string or a number, return the corresponding ERR.";
"If not found or an execution error, return -1.";
if (typeof(string = args[1]) == STR)
  for e in (this.all_errors)
    if (tostr(e) == string)
      return e;
    endif
  endfor
elseif (typeof(number = args[1]) == INT)
  for e in (this.all_errors)
    if (toint(e) == number)
      return e;
    endif
  endfor
endif
return -1;
