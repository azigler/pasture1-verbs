#71:is_object_cleaned   this none this rxd

what = args[1];
if (!(where = what in this.clean))
  return 0;
else
  return {this.destination[where], this.requestors[where]};
endif
