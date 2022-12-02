#26:simpson   this none this rxd

"simpson({a,b},{f(a),f((a+b)/2),f(b)} [,INT ret-float])";
" -- given two endpoints, a and b, and the functions value at a, (a+b)/2, and b, this will calculate a numerical approximation of the integral using simpson's rule.";
"Entries can either be all INT or all FLOAT. Don't mix!";
"If the optional 3rd argument is provided and true, the answer is returned as a floating point regardless of what the input was. Otherwise, if the input was all INT, the answer is returned as {integer,fraction}";
{point, fcn, ?retfloat = 0} = args;
if (!retfloat && typeof(point[1]) == INT)
  numer = (point[2] - point[1]) * (fcn[1] + 4 * fcn[2] + fcn[3]);
  return this:parts(numer, 6);
else
  numer = tofloat(point[2] - point[1]) * (tofloat(fcn[1]) + 4.0 * tofloat(fcn[2]) + tofloat(fcn[3]));
  return numer / 6.0;
endif
