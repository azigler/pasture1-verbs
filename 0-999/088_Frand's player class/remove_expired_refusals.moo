#88:remove_expired_refusals   this none this rxd

"'remove_expired_refusals ()' - Remove refusal entries which are past their time limits.";
origins = {};
"Before removing any refusals, figure out which ones to remove. Removing one changes the indices and invalidates the loop invariant.";
for i in [1..length(this.refused_origins)]
  if (time() >= this.refused_until[i] || (typeof(this.refused_origins[i]) == OBJ && !$recycler:valid(this.refused_origins[i])))
    origins = {@origins, this.refused_origins[i]};
  endif
endfor
for origin in (origins)
  this:remove_refusal(origin, this:refusable_actions());
endfor
