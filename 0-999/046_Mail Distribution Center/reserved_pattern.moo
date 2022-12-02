#46:reserved_pattern   this none this rxd

":reserved_pattern(string)";
"  if string matches one of the reserved patterns for mailing list names, ";
"  we return that element of .reserved_patterns.";
string = args[1];
for p in (this.reserved_patterns)
  if (match(string, p[1]))
    return p;
  endif
endfor
return 0;
