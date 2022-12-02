#63:gc   this none this rxd

for x in (this.orphans)
  if (!valid(x) || (x.owner != $hacker && x in x.owner.owned_objects))
    this.orphans = setremove(this.orphans, x);
  endif
endfor
