#6:my_match_object   this none this rxd

":my_match_object(string [,location])";
return $string_utils:match_object(@{@args, this.location}[1..2], this);
