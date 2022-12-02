#91:"norm length"   this none this rxd

":norm(V) => FLOAT";
":length(V) => FLOAT";
"The norm is the length of a vector, the square root of the sum of the squares of its elements.";
"";
"In school, we all should have learned the Pythagorean Theorem of right triangles: The sum of the squares of the sides of a right triagle is equal to the square of the hypoteneuse. The Theorem holds true no matter how many dimensions are being considered. The length of a vector is equal to the square root of the sum of the squares of its components. The dot product of a vector with itself happens to be the sum of the squares of its components.";
"";
{v} = args;
return this:is_vector(v) ? sqrt(tofloat(this:dot_prod(v, v))) | E_TYPE;
