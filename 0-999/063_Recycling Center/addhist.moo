#63:addhist   this none this rxd

if (caller == this)
  h = this.history;
  if ((len = length(h)) > this.nhist)
    h = h[len - this.nhist..len];
  endif
  this.history = {@h, args};
endif
