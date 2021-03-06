

		X.25 PVC for Consat Initiated Calls


Steps required:

	1.  Remove calls to routines that build Incoming Call 
	    packet, taking care to do all initilization
	    that is interwoven with the packet building process.

	2.  Simulate reception of call accepted packet
	    and finish initialization.

	3.  Go directly to flow control ready state.

	4.  Send reset to DTE to indicate circuit is ready.

	5.  Send reset to DTE if call is cleared by consat,
	    do clean up.


Alternative implemenation:

	Inplement PVCs in Consat PAD.


Estimate:
	Requirements analysis		2 P-W
	Design				3 P-W
	Coding				8 P-W
	Alpha Testing			2 P-W
	Beta Testing			4 P-W

	Total				5 P-M



    