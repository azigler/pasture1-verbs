#68:_name   this none this rxd

":_name(string) => full option name corresponding to string ";
"               => $failed_match or $ambiguous_match as appropriate.";
if ((string = args[1]) in this.names || string in this.extras)
  return string;
endif
char = (namestr = this._namelist)[1];
if (!(i = index(namestr, char + string)))
  return $failed_match;
elseif (i != rindex(namestr, char + string))
  return $ambiguous_match;
else
  j = index(namestr[i + 1..$], char);
  return namestr[i + 1..i + j - 1];
endif
