#25:domain_literal   this none this rxd

":domain_literal(string)";
" => true iff string is a domain literal (i.e., numeric IP address).";
if (10 <= (len = length(hnum = strsub(args[1], ".", ""))))
  return toint(hnum[1..9]) && toint(hnum[6..len]);
else
  return toint(hnum);
endif
"SLEAZY CODE ALERT";
"... what I wanted to do was return toint(strsub(args[1],\".\",\"\"))";
"... but on a 32-bit machine, this has a 1 in 4294967296 chance of failing";
"... (e.g., on \"42.94.967.296\", though I'll grant this particular example";
"...  entails some very strange subnetting on net 42, to say the least).";
"... So we do something that is guaranteed to work so long as internet";
"... addresses stay under 32 bits --- a while yet...";
"";
"... As soon as we're sure match() is working, this will become a one-liner:";
return match(args[1], "[0-9]+%.[0-9]+%.[0-9]+%.[0-9]+");
