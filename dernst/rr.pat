:*****************************
:*****
:****
:	Patch to module: XCOMBK.F41, XCOMDD.F41, XCOMRM.F41
:	Change label:
:	Patch by:       JSOUNG
:	NSR number:     929
:	Version:        4.01
:	Description:
:	X.25 interface fails to send packet level RR on the
:	regular basis if the interface inhibits the RR packet.
:       Fix that the X.25 interface sends RR on the regular basis
:	if the RNR packet is inhibited.

patch(861125,1400,js,rw040+0c,,0a)
	je	pa1ptr,,
	j	rw040+16
conpatch(pa0ptr,,nigrps*2)
lstrnr	hs	nigrps
conpatch(pa1ptr,,12)
	tbt	r6,lstrnr,,
	je	rw020,,
	j	rw040+16,,
conpatch(psubax,,6)
	j	pa1ptr,,
conpatch(pa1ptr,,12)
	lb	r2,ppr,r1,
	stb	r2,tppr,r1,
	j	psubax+6,,
conpatch(cwrot+8,,4)
	j	cwr030
conpatch(cwr030+4,,0a)
	rbt	r5,winrox
	j	mmfra,,
conpatch(psubaa,,6)
	j	pa1ptr,,
conpatch(pa1ptr,,14)
	rbt	r1,lstrnr,,
	rbt	r1,obkpr,,
	lis	r0,1
	j	psubaa+6,,
conpatch(psubab,,6)
	j	pa1ptr,,
conpatch(pa1ptr,,14)
	sbt	r1,lstrnr,,
	sbt	r1,obkpr,,
	lis	r0,1
	j	psubab+6,,
endpatch(NSR#929-send packet level RR on the regular basis when IPRNR is set)

   