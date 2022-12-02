#26:"mean average"   this none this rxd

"Usage: mean(INT, INT, ... )";
"       mean({INT, INT, ...})";
"Returns the average of all integers provided.";
return this:sum(rlist = typeof(args[1]) == LIST ? args[1] | args) / length(rlist);
