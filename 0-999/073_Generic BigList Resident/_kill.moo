#73:_kill   this none this rxd

":_kill(node) destroys the given node.";
if (!(caller in {this, this._mgr}))
  return E_PERM;
endif
delete_property(this, args[1]);
