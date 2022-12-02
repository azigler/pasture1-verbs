#59:full_prep   this none this rxd

if (server_version() != this._version)
  this:_fix_preps();
endif
prep = args[1];
if (p = prep in this._short_preps)
  return this.prepositions[p];
elseif (p = prep in this._other_preps)
  return this.prepositions[this._other_preps_n[p]];
else
  return "";
endif
