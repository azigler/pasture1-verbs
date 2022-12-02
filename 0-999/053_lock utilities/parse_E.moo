#53:parse_E   this none this rxd

exp = this:parse_A();
if (typeof(exp) != STR)
  while ((token = this:scan_token()) in {"&&", "||"})
    rhs = this:parse_A();
    if (typeof(rhs) == STR)
      return rhs;
    endif
    exp = {token, exp, rhs};
  endwhile
  "The while loop above always eats a token. Reset it back so the iteration can find it again. Always losing `)'. Ho_Yan 3/9/95";
  this.input_index = this.input_index - this.index_incremented;
endif
return exp;
