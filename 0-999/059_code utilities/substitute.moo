#59:substitute   this none this rxd

"$code_utils:substitute(string,subs) => new line";
"Subs are a list of lists, {{\"target\",\"sub\"},{...}...}";
"Substitutes targets for subs in a delimited string fashion, avoiding substituting anything inside quotes, e.g. player:tell(\"don't sub here!\")";
{s, subs} = args;
lets = "abcdefghijklmnopqrstuvwxyz0123456789";
for x in (subs)
  len = length(sub = x[1]);
  delimited = index(lets, sub[1]) && index(lets, sub[len]);
  prefix = "";
  while (i = index(s, sub))
    prefix = prefix + s[1..i - 1];
    if (prefix == "" || (!delimited || !index(lets, prefix[$])) && (!delimited || (i + len > length(s) || !index(lets, s[i + len]))) && !this:inside_quotes(prefix))
      prefix = prefix + x[2];
    else
      prefix = prefix + s[i..i + len - 1];
    endif
    s = s[i + len..length(s)];
  endwhile
  s = prefix + s;
endfor
return s;
