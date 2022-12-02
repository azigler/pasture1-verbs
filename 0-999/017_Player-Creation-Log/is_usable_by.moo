#17:is_usable_by   this none this rxd

"Copied from Generic Mail Recipient (#6419):is_usable_by by Rog (#4292) Tue Mar  2 10:02:32 1993 PST";
return !this.moderated || (this:is_writable_by(who = args[1]) || who in this.moderated || who.wizard);
