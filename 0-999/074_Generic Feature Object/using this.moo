#74:"using this"   this none this rxd

"Proper usage for the Generic Feature Object:";
"";
"First of all, the Generic Feature Object is constructed with the idea";
"that its children will be @moved to #24300, which is kind of a warehouse";
"for feature objects.  If there's enough interest, I'll try to make the";
"stuff that works with that in mind optional.";
"";
"Make a short description.  This is so I can continue to have looking at";
"#24300 give the descriptions of each of the objects in its .contents.";
"The :look_msg automatically includes a pointer to `help <this object>',";
"so you don't have to.";
"";
"Put a list of the commands you want people to use in";
"<this object>.feature_verbs.  (You need to use the :set_feature_verbs";
"verb to do this.)";
"";
"When someone types `help <this object>', they will be told the comment";
"strings from each of the verbs named in .feature_verbs.";
