File 1)	DSKB:KERMSG.MAC[14,10,KERMIT,TOPS10]    	created: 1412 25-May-84
File 2)	DSKB:KERMSG.MAC[14,10,KERMIT,TOPS10,CSM]	created: 1303 05-Jun-84

1)1	;   0001  0	%TITLE 'KERMSG - Kermit message processing'
****
2)1	;[CSM] B361LB.REL is on SYS:, not DSKB:[1,5]
2)	;   0001  0	%TITLE 'KERMSG - Kermit message processing'
**************
1)1		.REQUEST  DSKB:B361LB.REL[1,5]
1)		RELOC	0
****
2)1	;[CSM]	.REQUEST  DSKB:B361LB.REL[1,5]
2)		.REQUEST  SYS:B361LB.REL	;[CSM]
2)		RELOC	0
**************
  