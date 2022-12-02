#1:contents   this none this rxd

"Returns a list of the objects that are apparently inside this one.  Don't confuse this with .contents, which is a property kept consistent with .location by the server.  This verb should be used in `VR' situations, for instance when looking in a room, and does not necessarily have anything to do with the value of .contents (although the default implementation does).  `Non-VR' commands (like @contents) should look directly at .contents.";
return this.contents;
