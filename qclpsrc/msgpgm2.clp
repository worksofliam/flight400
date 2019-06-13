PGM        PARM(&SYSVAL &NEWVAL)
DCL        &SYSVAL  *CHAR 10
DCL        &NEWVAL  *CHAR 20
DCLF       FILE(CBCLIB/MSGPANEL) RCDFMT(MSGPANEL)
           CHGVAR &MLINE2 ('System Value ' *CAT &SYSVAL *TCAT  +
                           ' changed to ...  ' *CAT &NEWVAL)
           SNDRCVF RCDFMT(MSGPANEL) WAIT(*NO)
           DLYJOB  DLY(000001)
ENDPGM    /* PRAISE JESUS */
