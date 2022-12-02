#153:match_social   this none this rxd

{match, ?string = 0} = args;
"the following line checks if string is 1, send a string of the matched social name back(this always picks the first element). Otherwise, send a map of the social back. If nothing was found, or there was an error, send 0.";
res = {};
for i in (mapkeys(this.socials))
  if (index(i, match) == 1)
    if (string == 1)
      res = res:add(i);
    else
      res = this.socials[i];
      break;
    endif
  endif
endfor
return res;
