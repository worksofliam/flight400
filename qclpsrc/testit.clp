PGM

DCL        &MM       *DEC   (2 0)   VALUE(02)
DCL        &DD       *DEC   (2 0)   VALUE(30)
DCL        &YY       *DEC   (4 0)   VALUE(1997)
DCL        &JL       *DEC   (5 0)   VALUE(00000)
DCL        &JLA      *CHAR   5

CALL       GTOJCV PARM(&MM &DD &YY &JL)
CHGVAR     &JLA &JL
SNDPGMMSG  MSG(&JLA)

ENDPGM
