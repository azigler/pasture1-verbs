#20:abbreviated_value   this none this rxd

"Copied from Mickey (#52413):abbreviated_value Fri Sep  9 08:52:41 1994 PDT";
":abbreviated_value(value,max_reslen,max_lstlev,max_lstlen,max_strlen,max_toklen)";
"";
"Gets the printed representation of value, subject to these parameters:";
" max_reslen = Maximum desired result string length.";
" max_lstlev = Maximum list level to show.";
" max_lstlen = Maximum list length to show.";
" max_strlen = Maximum string length to show.";
" max_toklen = Maximum token length (e.g., numbers and errors) to show.";
"";
"A best attempt is made to get the exact target size, but in some cases the result is not exact.";
{value, ?max_reslen = $maxint, ?max_lstlev = $maxint, ?max_lstlen = $maxint, ?max_strlen = $maxint, ?max_toklen = $maxint} = args;
return this:_abbreviated_value(value, max_reslen, max_lstlev, max_lstlen, max_strlen, max_toklen);
"Originally written by Mickey.";
