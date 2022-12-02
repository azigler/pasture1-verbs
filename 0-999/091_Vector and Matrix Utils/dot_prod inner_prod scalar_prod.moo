#91:"dot_prod inner_prod scalar_prod"   this none this rxd

":dot_prod(V1, V2) => NUM";
":inner_prod(V1, V2) => NUM";
"The dot, or inner, product of two vectors is the sum of the products of the corresponding elements of the vectors.";
"If V1 = {1, 2, 3} and V2 = {4, 5, 6}, then V1.V2 = 1*4 + 2*5 + 3*6 = 32";
"";
"The dot product is useful in computing the angle between two vectors, and the length of a vector. See 'help $matrix_utils:subtended_angle' and 'help $matrix_utils:length'.";
"";
"A . B = ABcos(THETA)  (A dot B equals the magnitude of A times the magnitude of B times the cosine of the angle between them.)";
"";
{v1, v2} = args;
if ((l = length(v1)) != length(v2) || !this:is_vector(v1) || !this:is_vector(v2))
  return raise("E_INVVEC", "Invalid Vector Format");
endif
temp = this:vector_mul(v1, v2);
result = typeof(temp[1]) == INT ? 0 | 0.0;
for n in [1..l]
  $command_utils:suspend_if_needed(0);
  result = result + temp[n];
endfor
return result;
