#26:precision   this none this rxd

":precision(FLOAT Number, INT Digits of Precision) => FLOAT Number";
"Cuts the given number to the given digits of precision.  Uses rounding.";
{digits, pre} = args;
mult = 10.0 ^ pre;
return this:rint(digits * mult) / mult;
