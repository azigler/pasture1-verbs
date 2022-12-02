#88:find_properties_on   this none this rxd

"'find_properties_on ()' -> list of objects - Return the objects that @find searches when looking for a property. The objects are searched (and the results printed) in the order returned. Feature objects are *not* included in the search. Duplicate entries are removed by the caller.";
return {this, this.location, @valid(this.location) ? this.location:contents() | {}, @this:contents()};
