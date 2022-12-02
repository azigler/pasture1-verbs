#88:ping_features   this none this rxd

":ping_features()";
" -- cleans up the .features list to remove !valid objects";
" ==> cleaned-up .features list";
features = this.features;
for x in (features)
  if (!$recycler:valid(x))
    features = setremove(features, x);
  endif
endfor
return this.features = features;
