#59:toerr   this none this rxd

"toerr(n), toerr(\"E_FOO\"), toerr(\"FOO\") => E_FOO.";
if (typeof(s = args[1]) != STR)
  n = toint(s) + 1;
  if (n > length(this.error_list))
    return 1;
  endif
elseif (!(n = s in this.error_names || "E_" + s in this.error_names))
  return 1;
endif
return this.error_list[n];
