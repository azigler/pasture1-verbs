#13:find_ord   this none this rxd

":_find_ord(tree,n,comp) ";
" => index of rightmost leaf for which :(comp)(n,:_ord(leaf)) is false.";
"returns 0 if true for all leaves.";
return args[1] ? this:_find_ord(caller, @args) | 0;
