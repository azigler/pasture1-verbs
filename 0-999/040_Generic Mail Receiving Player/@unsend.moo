#40:@unsend   any (out of/from inside/from) any rd

"USAGE: @unsend [message-sequence] from <player>";
"Attempts to unsend messages you sent to <player>. Per *B:Unsend, messages may not be unsent if they have been read, have been netforwarded to the player (@mail-option +netmail), or if the player has set emself so that mail may not be unsent from em (@mail-option +no_unsend). In addition, mail sent to multiple players may not be unsent unless it can be unsent from each recipient.";
"";
"The following message sequences are the only ones allowed:";
"";
"  before:<date>    - Strictly before the given date.";
"  after:<date>     - Strictly after the given date.";
"  since:<date>     - On or after the given date.";
"  until:<date>     - On or before the given date.";
"  subject:<string> - The subject contains the given string.";
"  body:<string>    - The message body contains the given string.";
"  last:<number>    - The last <number> messages you sent.";
"";
"If you do not specify a sequence, the default sequence stored in @mail-option @unsend will be used.";
base = dobjstr || this:mail_option(verb) || $mail_agent.("player_default_@unsend");
if (player != this)
  return player:tell(E_PERM);
elseif (typeof(base) == STR)
  seq = $string_utils:words(base);
else
  seq = base;
endif
who = $string_utils:match_player(iobjstr);
fail_msg = "Message(s) were not removed as expected. As per *B:Unsend, I cannot elaborate on why.";
if ($command_utils:player_match_failed(who, iobjstr))
  return;
elseif (typeof(res = $options["mail"]:parse({verb, @seq})) == STR)
  return player:notify(res);
elseif (who:mail_option("no_unsend") || $object_utils:has_callable_verb(who, "do_unsend") != {$mail_recipient_class})
  "Author's note: I'm not checking for +netmail. The player could have turned it on (or off) later. Netmailed messages are not saved on the player, so they can't be removed, anyway.";
  return player:notify(fail_msg);
endif
"The following loop weeds out `last:#' references, which need to be proccessed in a specific way.";
newseq = otherpeople = {};
last = 0;
for x in (seq)
  if (`x[1..5] == "last:" ! ANY')
    last = toint(x[6..$]);
  else
    newseq = {@newseq, x};
  endif
endfor
seq = {"new", "unkept:", tostr("from:", player), @newseq};
if (last > 0)
  seq = {@seq, tostr("last:", last)};
endif
ok = who:parse_message_seq(seq, who:current_message());
if (typeof(ok) != LIST)
  return player:notify(fail_msg);
endif
allmsgs = length($seq_utils:tolist(@ok));
count = missed = 0;
for position in ($list_utils:reverse($list_utils:range(allmsgs)))
  time = time() + 60;
  ok = position == allmsgs ? ok | who:parse_message_seq(seq, who:current_message());
  if (typeof(ok) == STR || !ok[1])
    break;
  elseif (time() > time)
    player:notify("Due to a mysterious time delay (probably incredible lag), your @unsend command has been aborted. Try again later.");
    count && player:notify(tostr(count, "message", count == 1 ? "" | "s", " were unsent before the command was aborted."));
    return otherpeople && player:notify(tostr("Message(s) were also removed from ", $string_utils:nn(otherpeople), "."));
  endif
  x = $seq_utils:tolist(@ok)[$ - missed];
  ok = {x, x + 1};
  whomail = who.messages;
  bad = 0;
  possible = {};
  "Check if a message was sent to multiple people and set them up for @unsend, too.";
  if ((recips = $mail_agent:parse_address_field((msg = whomail[x][2])[3])) == {who})
    who:do_unsend(ok);
    "Leaving the zombie messages kinda defeats the purpose of @unsend. Since use of @unsend removes any old zombie mail, and since I can't find any nice, tidy way to save the old zombie mail, we're just going to delete the new zombie mail outright. Those who don't like this can set emselves +no_unsend.";
    who.messages_going = {};
    count = count + 1;
    ticks_left() < 5000 || seconds_left() < 2 && suspend(1);
    continue;
  else
    if (ticks_left() / 5000 < length(recips) || seconds_left() < 2)
      suspend(1);
    endif
    "This runs on the principle that the same message text will be sent to each person. If their .messages is in a non-standard format, this will probably bomb. Such people should set themselves +no_unsend, anyway.";
    for y in (setremove(recips, who))
      time = time() + 60;
      if (!is_player(y) || y:mail_option("no_unsend") || $object_utils:has_callable_verb(y, "do_unsend") != {$mail_recipient_class} || typeof(z = y:parse_message_seq({"new", "unkept:"}, y:current_message())) == STR || !z)
        bad = 1;
      elseif (time() > time)
        player:notify("Due to a mysterious time delay (probably incredible lag), your @unsend command has been aborted. Try again later.");
        count && player:notify(tostr(count, "message", count == 1 ? "" | "s", " were unsent before the command was aborted."));
        return otherpeople && player:notify(tostr("Message(s) were also removed from ", $string_utils:nn(otherpeople), "."));
      else
        ymail = y.messages;
        numnum = 0;
        for post in ($seq_utils:tolist(@z))
          if (ymail[post][2] == msg)
            numnum = post;
            break;
          endif
        endfor
        if (!numnum)
          bad = 1;
        else
          z = {numnum, numnum + 1};
        endif
      endif
      possible = bad ? {} | {@possible, {y, z}};
      if (bad)
        break;
      endif
    endfor
  endif
  if (bad)
    missed = missed + 1;
  else
    for foo in ({{who, ok}, @possible})
      {person, sequence} = foo;
      person:do_unsend(sequence);
      "Leaving the zombie messages kinda defeats the purpose of @unsend. Since use of @unsend removes any old zombie mail, and since I can't find any nice, tidy way to save the old zombie mail, we're just going to delete the new zombie mail outright. Those who don't like this can set emselves +no_unsend.";
      person.messages_going = {};
      if (person != who)
        otherpeople = setadd(otherpeople, person);
      endif
    endfor
    count = count + 1;
  endif
endfor
if (!count || count != allmsgs)
  player:notify(fail_msg);
endif
count && player:notify(tostr(count, " message", count == 1 ? "" | "s", " unsent."));
otherpeople && player:notify(tostr("Message(s) were also removed from ", $string_utils:nn(otherpeople), "."));
