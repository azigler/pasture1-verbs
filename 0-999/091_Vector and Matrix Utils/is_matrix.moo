#91:is_matrix   this none this rxd

"A matrix is defined as a list of vectors, each having the smae number of elements.";
{m} = args;
if (typeof(m) != LIST || typeof(m[1]) != LIST)
  return 0;
endif
len = length(m[1]);
for v in (m)
  if (!this:is_vector(v) || length(v) != len)
    return 0;
  endif
endfor
return 1;
