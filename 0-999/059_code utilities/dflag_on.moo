#59:dflag_on   this none this rxd

"Syntax:  $code_utils:dflag_on()   => 0|1";
"";
"Returns true if the verb calling the verb that called this verb has the `d' flag set true. Returns false if it is !d. If there aren't that many callers, or the calling verb was a builtin such as eval, assume the debug flag is on for traceback purposes and return true.";
"This is useful for determining whether the calling verb should return or raise an error to the verb that called it.";
return length(c = callers()) >= 2 ? `index(verb_info(c[2][4], c[2][2])[2], "d") && 1 ! E_INVARG => 1' | 1;
