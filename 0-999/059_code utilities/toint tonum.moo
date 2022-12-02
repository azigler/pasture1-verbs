#59:"toint tonum"   this none this rxd

":toint(STR)";
"=> toint(s) if STR is numeric";
"=> E_TYPE if it isn't";
return match(s = args[1], "^ *[-+]?[0-9]+ *$") ? toint(s) | E_TYPE;
