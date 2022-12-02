#42:caller   this none this rxd

":caller([include line numbers])";
"  -- returns the first caller in the callers() stack distinct from `this'";
{?lineno = 0} = args;
c = callers(lineno);
{stage, lc, nono} = {1, length(c), {c[1][1], $nothing}};
while ((stage = stage + 1) <= lc && c[stage][1] in nono)
endwhile
return c[stage];
