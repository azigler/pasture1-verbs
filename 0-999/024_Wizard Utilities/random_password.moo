#24:random_password   this none this rxd

"Generate a random password of length args[1].  Alternates vowels and consonants, for maximum pronounceability.  Uses its own list of consonants which exclude F and C and K to prevent generating obscene sounding passwords.";
"Capital I and lowercase L are excluded on the basis of looking like each other.";
vowels = "aeiouyAEUY";
consonants = "bdghjmnpqrstvwxzBDGHJLMNPQRSTVWXZ";
len = toint(args[1]);
if (len)
  alt = random(2) - 1;
  s = "";
  for i in [1..len]
    newchar = alt ? vowels[random($)] | consonants[random($)];
    s = s + newchar;
    alt = !alt;
  endfor
  return s;
else
  return E_INVARG;
endif
