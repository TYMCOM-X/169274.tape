PATCH(850418,1200,DRE,SDSINF,,0C)
	J	PA1PTR,,
	J	SDMXXX,,
CONPATCH(PA1PTR,,1E)
	LIS	R5,XMSUAM
	STB	R5,XSSTAT,RL	:REPLY WITH UA TO DISC
	JFS	SDMXXY
SDMXXX	RBT	RL,REINIT	:DO LINK LEVEL STUFF NOW TO BRING LINK BACK UP
	RBT	RL,BCKFLG
SDMXXY	LIS	R5,0
	STB	R5,XPSTAT,RL	:CLEAR OUT ANY OUTSTANDING REQUESTS
	LIS	R5,PNARM	:SET STATE TO NOT ARMED
	J	SDMINF+0C,,
ENDPATCH(Do correct background processing when DM received)
   