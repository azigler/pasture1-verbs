#9:"mailme @mailme"   this none none rd

"Usage:  mailme <note>";
"  uses $network to sends the text of this note to your REAL internet email address.";
if (!this:is_readable_by(player))
  return player:tell("Sorry, but it seems to be written in some code that you can't read.");
elseif (!(email = $wiz_utils:get_email_address(player)))
  return player:tell("Sorry, you don't have a registered email address.");
elseif (!$network.active)
  return player:tell("Sorry, internet mail is disabled.");
elseif (!(text = this:text()))
  return player:tell($string_utils:pronoun_sub("%T is empty--there wouldn't be any point to mailing it."));
endif
player:tell("Mailing ", this:title(), " to ", email, ".");
player:tell("... ", length(text), " lines ...");
suspend(0);
$network:sendmail(email, this:titlec(), "", @text);
