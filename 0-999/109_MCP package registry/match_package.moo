#109:match_package   this none this rxd

{name} = args;
if (idx = name in this.package_names)
  return this.packages[idx];
else
  return $failed_match;
endif
