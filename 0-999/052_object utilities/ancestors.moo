#52:ancestors   this none this rxd

"Usage:  ancestors(object[, object...])";
"Return a list of all ancestors of the object(s) in args, with no duplicates.";
"If called with a single object, the result will be in order ascending up the inheritance hierarchy.  If called with multiple objects, it probably won't.";
return ancestors(@args);
