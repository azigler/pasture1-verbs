#46:parse_misc_headers   this none this rxd

":parse_misc_headers(msg,@extract_names)";
"Extracts the miscellaneous (i.e., not including Date: From: To: Subject:)";
"from msg (a mail message in the usual transmission format).";
"Extract_names is a list of header names";
"=> {other_headers,bogus_headers,extract_texts,body}";
"where each element of extract_texts is a string or 0";
"  according as the corresponding header in extract_names is present.";
"bogus_headers is a list of those headers that are undecipherable";
"other_headers is a list of {header_name,header_text} for the remaining";
"  miscellaneous headers.";
"headers in msg";
msgtxt = args[1];
extract_names = listdelete(args, 1);
extract_texts = $list_utils:make(length(extract_names));
heads = bogus = {};
for h in (msgtxt[5..(bstart = "" in {@msgtxt, ""}) - 1])
  if (m = match(h, "%([a-z1-9-]+%): +%(.*%)"))
    hname = h[m[3][1][1]..m[3][1][2]];
    htext = h[m[3][2][1]..m[3][2][2]];
    if (i = hname in extract_names)
      extract_texts[i] = htext;
    else
      heads = {@heads, {hname, htext}};
    endif
  else
    bogus = {@bogus, h};
  endif
endfor
return {heads, bogus, extract_texts, msgtxt[bstart + 1..$]};
