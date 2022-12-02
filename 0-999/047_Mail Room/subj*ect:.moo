#47:subj*ect:   any any any rd

if (!(who = this:loaded(player)))
  player:tell(this:nothing_loaded_msg());
elseif (!argstr)
  player:tell(this.subjects[who]);
elseif (ERR == typeof(subj = this:set_subject(who, argstr)))
  player:tell(subj);
else
  player:tell(subj ? "Setting the subject line for your message to \"" + subj + "\"." | "Deleting the subject line for your message.");
endif
