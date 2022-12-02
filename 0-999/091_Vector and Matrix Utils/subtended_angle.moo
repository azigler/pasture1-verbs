#91:subtended_angle   this none this rxd

":subtended_angle(V1, V2) => FLOAT smallest angle defined by V1, V2 in radians";
"";
"Any two vectors define two angles, one less than or equal to 180 degrees, the other 180 degrees or more. The larger can be determined from the smaller, since their sum must be 360 degrees.";
"";
"The dot product of the two angles, divided by the lengths of each of the vectors is the cosine of the smaller angle defined by the two vectors.";
"";
{v1, v2} = args;
if ((l = length(v1)) != length(v2) || !this:is_vector(v1) || !this:is_vector(v2))
  return raise("E_INVVEC", "Invalid Vector Format");
endif
return acos(tofloat(this:dot_prod(v1, v2)) / (this:norm(v1) * this:norm(v2)));
