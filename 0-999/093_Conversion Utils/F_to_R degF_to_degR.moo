#93:"F_to_R degF_to_degR"   this none this rxd

":F_to_R (INT|FLOAT <Fahrenheit>) => FLOAT <Rankine>";
"This verb converts Fahrenheit degrees to Rankine degrees.";
return tofloat(args[1]) + 459.67;
