#20:pronoun_quote   this none this rxd

" pronoun_quote(string) => quoted_string";
" pronoun_quote(list of strings) => list of quoted_strings";
" pronoun_quote(list of {key,string} pairs) => list of {key,quoted_string} pairs";
"";
"Here `quoted' means quoted in the sense of $string_utils:pronoun_sub, i.e., given a string X, the corresponding `quoted' string Y is such that pronoun_sub(Y) => X.  For example, pronoun_quote(\"--%Spam%--\") => \"--%%Spam%%--\".  This is for including literal text into a string that will eventually be pronoun_sub'ed, i.e., including it in such a way that the pronoun_sub will not expand anything in the included text.";
"";
"The 3rd form above (with {key,string} pairs) is for use with $string_utils:substitute().  If you have your own set of substitutions to be done in parallel with the pronoun substitutions, do";
"";
"  msg=$string_utils:substitute(msg,$string_utils:pronoun_quote(your_substs));";
"  msg=$string_utils:pronoun_sub(msg);";
if (typeof(what = args[1]) == STR)
  return strsub(what, "%", "%%");
else
  ret = {};
  for w in (what)
    if (typeof(w) == LIST)
      ret = listappend(ret, listset(w, strsub(w[2], "%", "%%"), 2));
    else
      ret = listappend(ret, strsub(w, "%", "%%"));
    endif
  endfor
  return ret;
endif
