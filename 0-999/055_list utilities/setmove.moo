#55:setmove   this none this rxd

"Copied from Moo_tilities (#332):setmove by Mooshie (#106469) Mon Sep 22 21:07:25 1997 PDT";
"Usage: setmove(LIST elements, INT from, INT to)";
"Moves element in list from one position in list to another.";
"";
"Example: setmove({x, y, z}, 1, 3) => {y, z, x}";
"         setmove({x, y, z}, 2, 1} => {y, x, z}";
{start, from, to} = args;
what = start[from];
return listinsert(listdelete(start, from), what, to);
"  Written by Mooshie (#106469) @ Lambda - Mon Sep 22 21:03:26 1997 PDT -  ";
