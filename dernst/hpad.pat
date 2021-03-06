::	The following patch fixes a problem with the HPAD.
::	The timer cell was being set up correctly, but the flag
::	that caused the background timer code to run was not set.

PATCH(860203,1800,DRE,ICP040-6,,6)
	J	PA1PTR,,
CONPATCH(PA1PTR,,10)
	STB	R0,IDLCNT,R1,
	RBT	R1,NDATIM		:ENABLE TIMER
	J	ICP040,,
ENDPATCH(Set host pad timer on in host pad)
 