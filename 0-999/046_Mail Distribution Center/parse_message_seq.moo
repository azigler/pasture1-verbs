#46:parse_message_seq   this none this rxd

"parse_message_seq(strings,cur[,last_old])";
"This is the default <message-sequence> parsing routine for those mail commands that refer to sequences of messages (@mail, @read,...) on a folder.";
"  caller (the folder) is assumed to be a $mail_recipient or a player.";
"  strings is the <message-sequence> portion of the arg list.";
"  cur is the number of the player's current message for this folder.";
"Returns a string error message if the parse fails, otherwise";
"returns a list {msg_seq, @unused_strings}, where";
"   msg_seq is a handle understood by caller:display_seq_full/headers(), and ";
"   unused_strings is the list of remaining uninterpreted strings";
set_task_perms(caller_perms());
{strings, ?cur = 0, ?last_old = 0} = args;
if (!(nummsgs = caller:length_all_msgs()))
  return "%f %<has> no messages.";
elseif (typeof(strings) != LIST)
  strings = {strings};
endif
seq = result = {};
mode = #0;
"... changes to 0 if we start seeing message numbers, to 1 if we see masks...";
keywords = ":from:%from:to:%to:subject:body:before:after:since:until:first:last:kept:unkept";
keyalist = {{1, "from"}, {6, "%from"}, {12, "to"}, {15, "%to"}, {19, "subject"}, {27, "body"}, {32, "before"}, {39, "after"}, {45, "since"}, {51, "until"}, {57, "first"}, {63, "last"}, {68, "kept"}, {73, "unkept"}};
strnum = 0;
for string in (strings)
  strnum = strnum + 1;
  $command_utils:suspend_if_needed(0);
  if (string && ((c = index(string, ":")) && ((k = index(keywords, ":" + string[1..c - 1])) && k == rindex(keywords, ":" + string[1..c - 1]))))
    "...we have a mask to apply...";
    keywd = $list_utils:assoc(k, keyalist)[2];
    if (mode == #0)
      seq = {1, nummsgs + 1};
    endif
    mode = 1;
    if (k <= 27)
      "...from, subject, to, body...";
      pattern = string[c + 1..$];
      if (keywd in {"subject", "body"})
      elseif (keywd[1] == "%")
        pattern = $string_utils:explode(pattern, "|");
      else
        pattern = this:(keywd == "to" ? "_parse_to" | "_parse_from")(pattern);
        if (typeof(pattern) == STR)
          return pattern;
        endif
      endif
      seq = caller:(keywd + "_msg_seq")(pattern, seq);
      if (typeof(seq) == STR)
        if (strnum == 1)
          return seq;
        else
          seq = {};
        endif
      endif
    elseif (k <= 51)
      "...before, since, after, until...";
      if (typeof(date = this:_parse_date(string[c + 1..$])) != INT)
        return tostr("Bad date `", string, "':  ", date);
      endif
      s = caller:length_date_le(keywd in {"before", "since"} ? date - 1 | date + 86399);
      if (keywd in {"before", "until"})
        seq = $seq_utils:remove(seq, s + 1, nummsgs);
      else
        seq = $seq_utils:remove(seq, 1, s);
      endif
    elseif (k <= 63)
      "...first, last...";
      if (n = toint(string[c + 1..$]))
        seq = $seq_utils:(keywd + "n")(seq, n);
      else
        return tostr("Bad number in `", string, "'");
      endif
    else
      "...kept, unkept...";
      if (c < length(string))
        return tostr("Unexpected junk after `", keywd, ":'");
      elseif (!(seq = caller:(keywd + "_msg_seq")(seq)) && strnum == 1)
        return tostr("%f %<has> no ", keywd, " messages.");
      endif
    endif
  else
    "...continue building the present sequence...";
    if (mode)
      seq && (result = $seq_utils:union(result, seq));
      seq = {};
    endif
    mode = 0;
    if (!string)
      "...default case for @read: get the current message but skip to the next one if it's not there...";
      if (cur)
        i = min(caller:length_num_le(cur - 1) + 1, nummsgs);
        seq = $seq_utils:add(seq, i, i);
      else
        return "%f %<has> no current message.";
      endif
    elseif (index(string, "next") == 1 && !index(string, "-"))
      string[1..4] = "";
      if ((n = string ? toint(string) | 1) <= 0)
        return tostr("Bad number `", string, "'");
      elseif ((i = caller:length_num_le(cur) + 1) <= nummsgs)
        seq = $seq_utils:add(seq, i, min(i + n - 1, nummsgs));
      else
        return "%f %<has> no next message.";
      endif
    elseif (index(string, "prev") == 1 && !index(string, "-"))
      string[1..4] = "";
      if ((n = string ? toint(string) | 1) <= 0)
        return tostr("Bad number `", string, "'");
      elseif (i = caller:length_num_le(cur - 1))
        seq = $seq_utils:add(seq, max(1, i - n + 1), i);
      else
        return "%f %<has> no previous message.";
      endif
    elseif (string == "new")
      s = last_old ? caller:length_date_le(last_old) | caller:length_num_le(cur);
      if (s < nummsgs)
        seq = $seq_utils:add(seq, s + 1, nummsgs);
      else
        return "%f %<has> no new messages.";
      endif
    elseif (string == "first")
      seq = $seq_utils:add(seq, 1, 1);
    elseif (n = toint(string) || (string in {"last", "$"} && -1 || (string == "cur" && cur)))
      if (n <= 0)
        seq = $seq_utils:add(seq, max(0, nummsgs + n) + 1, nummsgs);
      elseif (i = caller:exists_num_eq(n))
        seq = $seq_utils:add(seq, i, i);
      else
        return string == "cur" ? "%f's current message has been removed." | tostr("%f %<has> no message numbered `", string, "'.");
      endif
    elseif ((i = index(string, "..")) > 1 || (i = index(string, "-")) > 1)
      if ((start = toint(sst = string[1..i - 1])) > 0)
        s = caller:length_num_le(start - 1);
      elseif (sst in {"next", "prev", "cur"})
        s = max(0, caller:length_num_le(cur - (sst != "next")) - (sst == "prev"));
      elseif (sst in {"last", "$"})
        s = nummsgs - 1;
      elseif (sst == "first")
        s = 0;
      else
        return {$seq_utils:union(result, seq), @strings[strnum..$]};
      endif
      j = string[i] == "." ? i + 2 | i + 1;
      if ((end = toint(est = string[j..$])) > 0)
        e = caller:length_num_le(end);
      elseif (est in {"next", "prev", "cur"})
        e = min(nummsgs, caller:length_num_le(cur - (est == "prev")) + (est == "next"));
      elseif (est in {"last", "$"})
        e = nummsgs;
      elseif (est == "first")
        e = 1;
      else
        return {$seq_utils:union(result, seq), @strings[strnum..$]};
      endif
      if (s < e)
        seq = $seq_utils:add(seq, s + 1, e);
      else
        return tostr("%f %<has> no messages in range ", string, ".");
      endif
    elseif (string == "cur")
      return "%f %<has> no current message.";
    else
      return {$seq_utils:union(result, seq), @strings[strnum..$]};
    endif
  endif
endfor
return {$seq_utils:union(result, seq)};
