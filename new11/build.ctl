:PARAMETERS NODE=2770
;BUILD.CTL builds SV####.IMG and ND####.BND for TXSnet NODE=\NODE\
DIRECT CG\NODE\.MAC
RUN (TOOLS11)MACN11
MC\NODE\.CMD@
RUN (TOOLS11)LINK11
@LK\NODE\.CMD/E
DELETE CG\NODE\.OBJ,RU\NODE\.OBJ
RUN (TOOLS11)NIBTRN
SV\NODE\.IMG
ND\NODE\.BND
DIRECT ##\NODE\.*/TODAY
 