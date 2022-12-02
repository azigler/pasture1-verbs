#113:verbcode_external_to_internal   this none this rxd

"Charter: given a block of verb code lines from the user, transform it into code ready to be passed to set_verb_code().  In particular, reverse any transformation made by :verbcode_internal_to_external.";
"This version transforms `// foo' comments to `\"foo\";' comments.";
lines = args[1];
new_comments = player:prog_option("//_comments");
if (!new_comments)
  return lines;
endif
newlines = {};
for line in (lines)
  mat = match(line, "^ *// ?%(.*%)$");
  if (mat)
    comment = substitute("%1", mat);
    out = $code_utils:commentify({comment});
    newlines = {@newlines, out[1]};
  else
    newlines = {@newlines, line};
  endif
endfor
return newlines;
