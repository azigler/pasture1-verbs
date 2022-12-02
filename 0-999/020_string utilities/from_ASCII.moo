#20:from_ASCII   this none this rxd

"This converts a ASCII character code in the range [32..126] into the ASCII character with that code, represented as a one-character string.";
"";
"Example:   $string_utils:from_ASCII(65) => \"A\"";
code = args[1];
return this.ascii[code - 31];
