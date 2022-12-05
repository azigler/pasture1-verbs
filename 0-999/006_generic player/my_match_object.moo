#6:my_match_object   this none this rxd

":my_match_object(string [,location])";
{string, ?olist = {@this:contents(), @this.location:contents()}} = args;
"if(typeof(olist)==obj);";
"olist = olist:contents();";
"endif";
typeof(olist) == OBJ && (olist = {@this:contents(), @olist:contents()});
try
  return $match_utils:match(string, olist);
except e (ANY)
  player:tell("An error has been encountered: " + e[2]);
  return $string_utils:match_object(@{@args, this.location}[1..2], this);
endtry
"Last modified Mon Dec  5 19:24:12 2022 UTC by caranov (#133).";
