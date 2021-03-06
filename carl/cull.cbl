Identification Division.
Program-id.  CULL.
Author.  Glenn Ricart.
Installation.  National Institutes of Health,
	Bethesda, Maryland 20014
Date-written.  February 4, 1974.
Date-compiled.
Security.  Unclassified.
Remarks.
	THIS PROGRAM READS CREF FILES PRODUCED BY DEC
	CREF WITH /S SWITCH AND PRODUCES A GLOBAL CULL.

	To change this program to run for you:
	Select the structure on which the .LST files have
	been placed for UFD-FILE and CREF-LISTING. (See
	File-control paragraph of Input-output section.)
	This is currently DSK.  Change it to yours.

	Use something (the CONV.SAI program in this area) or
	SOS to make sure that the CREF files terminate in CRLF.
	There is currently (1977) a bug in CREF that the last
	line of a CREF may not have a CRLF.  COBOL will blow up
	when it hits such a line, so you must make sure that
	there is one there.

	Use PIP to convert the files to expand tabs (use /W).
	COBOL can't find the fixed format of CREF correctly if the
	tabs are not expanded.

	The three devices to use for a sort (tapes are good)
	go into the select for SORT-FILE.
	Or, you can give them the logical names DSK1, DSK2, and DSK3.
	Note, SORT-10 seems to require disks for this purpose.
	For the best change of all, figure out your PPN in
	SIXBIT ([13,20] is '  +  0') and put it in
	UFD-FILE-name under value is clause.

	Directions for running:
	<make sure no spurious .LST files, or whatever extension
	 you are using (CREF on Dsk likes .LST)>
	.Assign Dsk Lpt
	<cref all files here>
	.Deassign Lpt
	<use CONV.SAI or SOS or corrected version of CREF to>
	<make sure last line of CREF file has CRLF>
	<Use PIP with W switch to expand tabs to spaces>
	.Execute Cull
	<Cull will run>
	<Output is on COMBIN.LST>


	Any improvements on this program should be forwarded to
	Glenn Ricart, Building 12A, Room 1039, National
	Institutes of Heatlh, Bethesda, Maryland  20014.

	Caveat: Be careful in changing the casing of names in
	this program.  Some changes of upper case names to
	lower case names cause the compiler to go crazy.

	Note for running this program with the MONF1 series of
	control files: change the line that has 'LST' on it to 'SYM'
	because the MONF1 series of control files has the /S listings
	with names with extension SYM instead of LST.

Environment Division.
Configuration section.
Source-computer.  DECsystem-10.
Object-computer.  DECsystem-10.
Input-output section.
File-control.  Select UFD-FILE assign to DSK 
	access mode is sequential recording mode is binary.
	Select CREF-LISTING assign to DSK access mode is sequential recording mode is ascii.
	Select COMBINED-LISTINGS assign to dsk access mode is sequential recording mode is ascii.
	SELECT SORT-FILE ASSIGN TO DSK,DSK,DSK.

Data Division.
File section.
FD UFD-FILE label records are standard
	value of identification is UFD-FILE-name
	user-number is 1,1
	data records are ufd-entries.
01 ufd-entries usage is display-6.
	02 UFD-FILE-name-entry picture X(6).
	02 ufd-extension-entry picture X(3).
	02 ufd-supercluster-pointer picture X(3).
	02 filler picture X(18).
FD CREF-LISTING label records are standard value of identification is CREF-LISTING-name
	data records are cref-lines.
01 cref-lines picture X(133).
FD COMBINED-LISTINGS label records are standard 
	value of identification is combined-listing-name
	data records are output-line.
01 OUTPUT-LINE.
	02 SYMBOL-OUT PICTURE X(6).
	02 FILLER PICTURE XX.
	02 ELEMENT-OUT PICTURE X(6).
	02 FILLER PICTURE XX.
	02 REFS-OUT PICTURE X(116).
SD SORT-FILE DATA RECORDS ARE SORT-LINE.
01 SORT-LINE.
	02 SYMBOL-ID PICTURE X(6).
	02 ELEMENT-ID PICTURE X(6).
	02 SYMBOL-REFS PICTURE X(120).

Working-storage section.
77 combined-listing-name picture X(9) value is 'COMBINLST'.
01 CREF-LISTING-NAME USAGE IS DISPLAY-6.
	02 FILE-PART PICTURE X(6).
	02 EXTENS-PART PICTURE X(3).
77 UFD-FILE-name picture X(9) usage is display-6 value is '  +  0UFD'.
01 NAME-BUFFER.
	02 SYMBOL-ENTRY PICTURE X(6).
	02 FILLER PICTURE XX.
	02 ORIG-REFS PICTURE X(120).
01 SECONDARY-LINE REDEFINES NAME-BUFFER.
	02 SECONDARY-KEY PICTURE X(8).
	02 SECONDARY-REFS PICTURE X(120).
77 ID1 PICTURE 9(6).
77 REMEMBER-SYMBOL PICTURE X(6).
77 ID2 PICTURE 9(6).
77 ID3 PICTURE 9(6).
77 ID4 PICTURE 9(6).
01 OUTPUT-COMPOSER.
	02 SYMBOL-COMP PICTURE X(6).
	02 FILLER PICTURE XX VALUE IS '  '.
	02 ELEMENT-COMP PICTURE X(6).
	02 FILLER PICTURE XX VALUE IS '  '.
	02 REFS-COMP PICTURE X(120).

Procedure Division.
Initialize.  Open input UFD-FILE, output COMBINED-LISTINGS.
	SORT SORT-FILE ON ASCENDING KEY SYMBOL-ID, ELEMENT-ID, SYMBOL-REFS
	INPUT PROCEDURE IS INPUT-SECTION;
	OUTPUT PROCEDURE IS OUTPUT-SECTION.
	CLOSE COMBINED-LISTINGS.
	DISPLAY "DONE."
	STOP RUN.
INPUT-SECTION SECTION.
Ufd-sift.  Read UFD-FILE; at end go to clean-up.
	If ufd-extension-entry is equal to 'LST' perform process-file
	THROUGH END-PROCESS.
	Go to Ufd-sift.
CLEAN-UP.  CLOSE UFD-FILE.
	DISPLAY "SORTING".
	GO TO SECTION-A-END.
Process-file.
	MOVE UFD-FILE-NAME-ENTRY TO FILE-PART.
	MOVE UFD-EXTENSION-ENTRY TO EXTENS-PART.
	OPEN INPUT CREF-LISTING.
	DISPLAY 'CULL: ' FILE-PART.
CYCLE-LOOP.
	READ CREF-LISTING INTO NAME-BUFFER; AT END GO TO END-PROCESS.
	IF SECONDARY-KEY IS NOT GREATER THAN ' '
		MOVE SECONDARY-REFS TO SYMBOL-REFS
		MOVE REMEMBER-SYMBOL TO SYMBOL-ID; ELSE
	MOVE SYMBOL-ENTRY TO SYMBOL-ID
	MOVE SYMBOL-ENTRY TO REMEMBER-SYMBOL
	MOVE ORIG-REFS TO SYMBOL-REFS.
	MOVE FILE-PART TO ELEMENT-ID.
	RELEASE SORT-LINE.
	GO TO CYCLE-LOOP.
END-PROCESS.
	CLOSE CREF-LISTING.
SECTION-A-END.
	NOTE SORT NOW PROCEEDS.
OUTPUT-SECTION SECTION.
BEGIN-OUT-SECTION.
	DISPLAY 'SORT COMPLETE.  PRINTING OUTPUT.'
OUTPUT-LOOP.
	RETURN SORT-FILE RECORD; AT END GO TO END-OUTPUT-SECTION.
	IF SYMBOL-COMP IS EQUAL TO SYMBOL-ID
		MOVE SPACES TO SYMBOL-OUT;
		ELSE MOVE SYMBOL-ID TO SYMBOL-OUT
		MOVE SPACES TO ELEMENT-COMP.
	IF ELEMENT-COMP IS EQUAL TO ELEMENT-ID
		MOVE SPACES TO ELEMENT-OUT;
		ELSE MOVE ELEMENT-ID TO ELEMENT-OUT.
	MOVE SYMBOL-REFS TO REFS-OUT.
	WRITE OUTPUT-LINE.
	MOVE SYMBOL-ID TO SYMBOL-COMP.
	MOVE ELEMENT-ID TO ELEMENT-COMP.
	GO TO OUTPUT-LOOP.
END-OUTPUT-SECTION.
	NOTE HERE WE ARE!.
  