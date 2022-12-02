#55:slice   this none this rxd

"slice(alist[,index]) returns a list of the index-th elements of the elements of alist, e.g., ";
"    slice({{\"z\",1},{\"y\",2},{\"x\",5}},2) => {1,2,5}.";
"index defaults to 1 and may also be a nonempty list, e.g., ";
"    slice({{\"z\",1,3},{\"y\",2,4}},{2,1}) => {{1,\"z\"},{2,\"y\"}}";
"For compatibility with LambdaCore, threading is disabled by default.";
set_thread_mode(0);
return slice(@args);
