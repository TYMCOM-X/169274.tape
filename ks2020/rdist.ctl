:logfile rdist.log
:define $substitution=$true
sysno
run (xexec)minit
rdist *.*/master:33/host:14,17,32/check
copy rdist.log,rdist.out
mung findit,rdist.out
copy rdist.log,rdist.\$weekday\
rdist rdist.*/host:14,17,32,33
      