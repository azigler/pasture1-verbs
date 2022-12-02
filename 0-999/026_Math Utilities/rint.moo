#26:rint   this none this rxd

":rint(FLOAT Number) => FLOAT Number";
"Returns the given floating-point number rounded to the nearest integer, as a floating-point number.  In case of ties, rounds away from 0.";
{f} = args;
return trunc(f > 0.0 ? f + 0.5 | f - 0.5);
