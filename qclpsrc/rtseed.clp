PGM        PARM(&SEED)

DCL        &SEED     *DEC   (9 9)

DCL        &HMSTTT   *CHAR  9
DCL        &HMSTAA   *CHAR  3
DCL        &HMSTBB   *CHAR  3
DCL        &HMSTCC   *CHAR  3

DCL        &HMST11   *DEC   (3 0)
DCL        &HMST22   *DEC   (3 0)
DCL        &HMST33   *DEC   (3 0)

RTVSYSVAL  SYSVAL(QTIME) RTNVAR(&HMSTTT)
CHGVAR     &HMSTAA   %SST(&HMSTTT 7 3)
CHGVAR     &HMST11   &HMSTAA

RTVSYSVAL  SYSVAL(QTIME) RTNVAR(&HMSTTT)
CHGVAR     &HMSTBB   %SST(&HMSTTT 7 3)
CHGVAR     &HMST22   &HMSTBB

RTVSYSVAL  SYSVAL(QTIME) RTNVAR(&HMSTTT)
CHGVAR     &HMSTCC   %SST(&HMSTTT 7 3)
CHGVAR     &HMST33   &HMSTCC

CHGVAR     &SEED     ((&HMST33 / 1000000000) + +
                      (&HMST22 / 1000000)    + +
                      (&HMST11 / 1000))

END:        ENDPGM
