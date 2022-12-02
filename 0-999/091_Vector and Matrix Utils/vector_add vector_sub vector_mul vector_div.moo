#91:"vector_add vector_sub vector_mul vector_div"   this none this rxd

":vector_add(V1 [,V2 ...]) => VN such that VN[n] = V1[n] + V2[n]...";
":vector_sub(V1 [,V2 ...]) => VN such that VN[n] = V1[n] - V2[n]...";
":vector_mul(V1 [,V2 ...]) => VN such that VN[n] = V1[n] * V2[n]...";
":vector_div(V1 [,V2 ...]) => VN such that VN[n] = V1[n] / V2[n]...";
"Vectors do not need to be the same length, but they should be. VN's length will be the length of the longest vector in the arguments. :vector_add and :vector_sub will pad out the smaller vectors with 0's or 0.0's. :vector_mul and :vector_div will pad out the smaller vectors with 1's or 1.0's. Vectors do not need to contain homogeneous data, but the nth term of each vector must be of the same type.";
"I can see a reason for wanting to do vector addition or subtraction, but multiplication and divareion is usually handled in other ways. I've included them here for novelty, and becuase it was easy enough to do.";
"";
"Vector addition is used when two or more similar vector quantities are at work and need to be resolved into a single vector. For instance, a ship travelling in a current will be acted upon by (at least) two forces: a force propelling it forward (its engine), and a force pushing it off course (the current). The sum of these two forces gives the resultant net force acting upon the ship and, since Force = Mass * Acceleration, the direction the ship is accelerating.";
"";
"Vector subtraction can be used to reverse the process of vector addition. In the ship problem above, let's say the actual resultant force is known, but it does not match the result of adding the propelling force and the drifting force. Friction is probably acting against the motion of the ship. Subtracting the computed resultant force from the known net force will yield the frictional force acting against the progress of the ship.";
"";
"Vector multiplication and division do not have RL examples, but vector multiplication of this type makes computing the dot product of two vectors simple.";
"";
if (length(args) == 1)
  return args;
elseif (!args)
  return raise(E_INVARG);
endif
type = verb[$ - 2..$];
lresult = max = length(args[1]);
results = args[1];
for n in [2..length(args)]
  $command_utils:suspend_if_needed(0);
  if (type == "add")
    for m in [1..min(lcurr = length(args[n]), lresult)]
      results[m] = results[m] + args[n][m];
      $command_utils:suspend_if_needed(0);
    endfor
    if (lcurr > lresult)
      results[lresult + 1..lcurr] = args[n][lresult + 1..lcurr];
    endif
  elseif (type == "sub")
    for m in [1..min(lcurr = length(args[n]), lresult)]
      results[m] = results[m] - args[n][m];
      $command_utils:suspend_if_needed(0);
    endfor
    if (lcurr > lresult)
      for m in [lresult + 1..lcurr]
        results = {@results, -args[n][m]};
        $command_utils:suspend_if_needed(0);
      endfor
    endif
  elseif (type == "mul")
    for m in [1..min(lcurr = length(args[n]), lresult)]
      results[m] = results[m] * args[n][m];
      $command_utils:suspend_if_needed(0);
    endfor
    if (lcurr > lresult)
      results[lresult + 1..lcurr] = args[n][lresult + 1..lcurr];
    endif
  else
    for m in [1..min(lcurr = length(args[n]), lresult)]
      results[m] = results[m] / args[n][m];
      $command_utils:suspend_if_needed(0);
    endfor
    if (lcurr > lresult)
      for m in [lresult + 1..lcurr]
        results = {@results, typeof(foo = args[n][m]) == INT ? 1 / foo | 1.0 / foo};
        $command_utils:suspend_if_needed(0);
      endfor
    endif
  endif
endfor
return results;
