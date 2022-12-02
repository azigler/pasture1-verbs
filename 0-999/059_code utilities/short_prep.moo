#59:short_prep   this none this rxd

":short_prep(p) => shortest preposition equivalent to p";
"p may be a single word or one of the strings returned by verb_args().";
if (server_version() != this._version)
  this:_fix_preps();
endif
word = args[1];
word = word[1..index(word + "/", "/") - 1];
if (p = word in this._other_preps)
  return this._short_preps[this._other_preps_n[p]];
elseif (word in this._short_preps)
  return word;
else
  return "";
endif
