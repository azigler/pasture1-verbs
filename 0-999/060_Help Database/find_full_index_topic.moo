#60:find_full_index_topic   this none this rxd

":find_full_index_topic([search])";
"Return the *full_index* topic or 0";
"If search argument is given and true, we don't depend on cached info.";
{?search = 0} = args;
"... N.B.  There is no cached info; it turns out that";
"... full-index is near enough to the beginning of $help's property list";
"... that there's no point to doing this.  --Rog";
for p in (`properties(this) ! E_PERM => {}')
  if (`this.(p)[1] ! ANY' == "*full_index*")
    return p;
  endif
endfor
return 0;
