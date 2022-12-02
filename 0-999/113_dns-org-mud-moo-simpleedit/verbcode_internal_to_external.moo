#113:verbcode_internal_to_external   this none this rxd

"Charter: given a block of verb code from the verb_code() primitive, transform it into its external representation to be presented to the user.";
"This version transforms `\"foo\";' comments to `// foo' comments.";
lines = args[1];
new_comments = player:prog_option("//_comments");
if (!new_comments)
  return lines;
endif
newlines = {};
for line in (lines)
  mat = match(line, "^%( *%)%(\".*\";%)$");
  if (mat)
    blanks = substitute("%1", mat);
    comment = substitute("%2", mat);
    uncommented = $code_utils:uncommentify({comment});
    out = blanks + "// " + uncommented[1];
    newlines = {@newlines, out};
  else
    newlines = {@newlines, line};
  endif
endfor
return newlines;
