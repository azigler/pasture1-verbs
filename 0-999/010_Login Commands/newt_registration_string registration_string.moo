#10:"newt_registration_string registration_string"   this none this rxd

return $string_utils:subst(this.(verb), {{"%e", this.registration_address}, {"%%", "%"}});
