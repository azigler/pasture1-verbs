#53:parse_keyexp   this none this rxd

"parse_keyexp(STRING keyexpression, OBJ player) => returns a list containing the coded key, or a string containing an error message if the attempt failed.";
"";
"Grammar for key expressions:";
"";
"    E ::= A       ";
"       |  E || A  ";
"       |  E && A  ";
"    A ::= ( E )   ";
"       |  ! A     ";
"       |  object  ";
"       |  ? object  ";
this:init_scanner(args[1]);
this.player = args[2];
return this:parse_E();
