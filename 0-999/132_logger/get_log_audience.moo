#132:get_log_audience   this none this xd

{log} = args;
!caller_perms().wizard && raise(E_PERM);
return `this.(log + "_log")[1] ! E_PROPNF => raise(E_INVARG)';
"Last modified Wed Aug  9 15:04:44 2017 CDT by Coderunner Jason Perino (#97@ThetaCore).";
