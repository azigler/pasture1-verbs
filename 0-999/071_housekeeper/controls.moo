#71:controls   this none this rxd

"does player control entry I?";
{i, who} = args;
if (who in {this.owner, @this.owners} || who.wizard)
  return "Yessir.";
endif
cleanable = this.clean[i];
if (this.requestors[i] == who)
  return "you asked for the previous result, you can change this one.";
elseif (who == cleanable.owner || !valid(dest = this.destination[i]) || who == dest.owner)
  return "you own the object or the place where it is being cleaned to, or the destination is no longer valid.";
else
  return "";
endif
