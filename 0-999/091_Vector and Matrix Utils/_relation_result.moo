#91:_relation_result   this none this rxd

"Common code for is_reflexive, is_symmetric, and is_transitive.";
{good, bad, flag} = args;
if (good && !bad)
  result = 1;
elseif (!good && bad)
  result = -1;
else
  result = 0;
endif
return flag * result;
