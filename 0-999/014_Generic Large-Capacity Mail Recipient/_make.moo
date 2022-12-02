#14:_make   this none this rxd

":_make(...) => new node with value {...}";
if (!(caller in {this._mgr, this}))
  return E_PERM;
endif
prop = this:_genprop();
`add_property(this, prop, args, {this.mowner, ""}) ! ANY';
return prop;
