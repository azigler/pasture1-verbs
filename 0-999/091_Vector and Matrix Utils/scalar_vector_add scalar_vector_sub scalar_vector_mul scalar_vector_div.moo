#91:"scalar_vector_add scalar_vector_sub scalar_vector_mul scalar_vector_div"   this none this rxd

":scalar_vector_add(S, V) => VN such that VN[n] = V[n] + S...";
":scalar_vector_sub(S, V) => VN such that VN[n] = V[n] - S...";
":scalar_vector_mul(S, V) => VN such that VN[n] = V[n] * S...";
":scalar_vector_div(S, V) => VN such that VN[n] = V[n] / S...";
"Actually, arguments can be (S, V) or (V, S). Each element of V is augmented by S. S should be either an INT or a FLOAT, as appropriate to the values in V.";
"";
"I can see a reason for wanting to do scalar/vector multiplcation or division, but addition and subtraction between vector and scalar types is not done. I've included them here for novelty, and because it was easy enough to to.";
"";
"Scalar-vector multiplication stretches a vector along its direction, generating points along a line. One of the more famous uses from physics is Force equals mass times acceleration. F = ma. Force and acceleration are both vectors. Mass is a scalar quantity.";
"";
if (typeof(args[1]) == LIST)
  {vval, sval} = args;
else
  {sval, vval} = args;
endif
if (!this:is_vector(vval))
  return raise("E_INVVEC", "Invalid Vector Format");
endif
type = verb[$ - 2..$];
for n in [1..length(vval)]
  if (type == "add")
    vval[n] = vval[n] + sval;
  elseif (type == "sub")
    vval[n] = vval[n] - sval;
  elseif (type == "mul")
    vval[n] = vval[n] * sval;
  else
    vval[n] = vval[n] / sval;
  endif
endfor
return vval;
