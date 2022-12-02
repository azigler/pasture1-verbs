#91:"cross_prod outer_prod vector_prod"   this none this rxd

":cross_prod(V1, V2) => VN, the vector perpendicular to both V1 and V2 with length equal to the area of the parallelogram spanned by V1 and V2, and direction governed by the rule of thumb.";
"";
"If A = a1i + a2j + a3k, represented as a list as {a1, a2, a3}";
"and B = b1i + b2j + b3k, or {b1, b2, b3}, then";
"";
"        |i  j  k |";
"A x B = |a1 a2 a3| = |a2 a3|i - |a1 a3|j + |a1 a2|k";
"        |b1 b2 b3| = |b2 b3|    |b1 b3|    |b1 b2|";
"";
"or, in list terms, as the list of the coefficients of i, j, and k.";
"";
"Note: i, j, and k are unit vectors in the x, y, and z direction respectively.";
"";
"The rule of thumb: A x B = C  If you hold your right hand out so that your fingers point in the direction of A, and so that you can curl them through B as you make a hitchhiking fist, your thumb will point in the direction of C.";
"";
"Put another way, A x B = ABsin(THETA) (A cross B equals the magnitude of A times the magnitude of B times the sin of the angle between them) This is expressed as a vector perpendicular the the A-B plane, pointing `up' if you curl your right hand fingers from A to B, and `down' if your right hand fingers curl from B to A.";
"";
"The cross product has many uses in physics. Angular momentum is the cross product of a particles position vector from the point it is rotating around and it's linear momentum (L = r x p). Torque is the cross product of position and Force (t = r x F).";
"";
{v1, v2} = args;
if ((l = length(v1)) != length(v2) || l != 3 || !this:is_vector(v1) || !this:is_vector(v2))
  return raise("E_INVVEC", "Invalid Vector Format");
endif
mat = {{1, 1, 1}, v1, v2};
coeff = 1;
result = {};
for n in [1..3]
  result = {@result, coeff * this:determinant(this:submatrix(1, n, mat))};
  coeff = -coeff;
endfor
return result;
