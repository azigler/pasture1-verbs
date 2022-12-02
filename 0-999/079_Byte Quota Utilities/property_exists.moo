#79:property_exists   this none this rxd

"this:property_exists(object, property)";
" => does the specified property exist?";
return !!`property_info(@args) ! ANY';
