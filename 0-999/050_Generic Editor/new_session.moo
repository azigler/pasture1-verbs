#50:new_session   this none this rxd

"WIZARDLY";
{who_obj, from} = args;
if ($object_utils:isa(from, $generic_editor))
  "... never put an editor in .original, ...";
  if (w = who_obj in from.active)
    from = from.original[w];
  else
    from = #-1;
  endif
endif
if (caller != this)
  return E_PERM;
elseif (who = who_obj in this.active)
  "... edit in progress here...";
  if (valid(from))
    this.original[who] = from;
  endif
  return -1;
else
  for p in ({{"active", who_obj}, {"original", valid(from) ? from | $nothing}, {"times", time()}, @this.stateprops})
    this.(p[1]) = {@this.(p[1]), p[2]};
  endfor
  return length(this.active);
endif
