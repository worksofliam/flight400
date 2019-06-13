PGM

DCL           &CHKFLD *DEC (5 0)

CHGVAR        &CHKFLD 00000

LOOP:

IF            (&CHKFLD *NE 25000) DO
                                  CHGVAR &CHKFLD (&CHKFLD+00001)
                                  GOTO   LOOP
                                  ENDDO

/* DCLF       FILE(FLGHT400/MSGPANEL) RCDFMT(MSGPANEL)   */
/*            CHGVAR &MLINE2 ('PROCESSING ORDER...')     */
/*            SNDRCVF RCDFMT(MSGPANEL) WAIT(*NO)         */
/*            DLYJOB  DLY(000001)                        */
ENDPGM
