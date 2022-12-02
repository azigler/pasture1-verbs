#20:to_ASCII   this none this rxd

"Convert a one-character string into the ASCII character code for that character.";
"";
"Example:  $string_utils:to_ASCII(\"A\") => 65";
return (index(this.ascii, args[1], 1) || raise(E_INVARG)) + 31;
