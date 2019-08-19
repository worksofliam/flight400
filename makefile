BIN_LIB=FLGHT400
BIN_LIB_ILE=$(BIN_LIB)M
SYSTEM=-s

SHELL=/QOpenSys/usr/bin/qsh
LIBLIST=FLGHT400 $(BIN_LIB) $(BIN_LIB_ILE)

LIB_TARGETS=$(BIN_LIB).lib $(BIN_LIB_ILE).lib

PGM_TARGETS=bcust.rpg bflght.rpg frs000.rpg frs001.rpg frs001.rpg frs001t.rpg \
            frs001u.rpg frs001u2.rpg frs002.rpg frs003.rpg frs004.rpg frs005.rpg \
						frs009.rpg frs021.rpg frs022.rpg frs023.rpg frs024.rpg frs401.rpg \
						frs402.rpg frs401b.rpg frs402.rpg frs402b.rpg frs405.rpg frs406.rpg \
						frs407.rpg frs408.rpg frs409.rpg frs410.rpg frs411.rpg frs412.rpg \
						frs412.rpg gtojcv.rpg rtdofw.rpg rtrand.rpg bldcst.clp frs001cl.clp \
						frs411cl.clp msgprg.clp msgprgh.clp rtseed.clp testit.clp \
						useclear.clp usereset.clp

MENU_TARGETS=frsmain.mnucmd frsmant.mnucmd frsrept.mnucmd

DSP_TARGETS=frs000df.dspf frs001df.dspf frs002df.dspf frs003df.dspf frs004df.dspf \
		 				frs005df.dspf frs009df.dspf frs021df.dspf frs022df.dspf frs023df.dspf \
						frs024df.dspf frs025df.dspf frs401df.dspf frs401df.dspf frs402df.dspf frs403df.dspf \
						frs404df.dspf frs405df.dspf frs406df.dspf frs407df.dspf frs408df.dspf \
						frs409df.dspf frs410df.dspf frs411df.dspf frs412df.dspf frs413df.dspf

CMD_TARGETS=useclear.cmd usereset.cmd

all: $(LIB_TARGETS) $(PGM_TARGETS) $(MENU_TARGETS) $(DSP_TARGETS) $(CMD_TARGETS)

## Below is the dep list

## Below are the generic targets

%.lib:
	-system -qi "CRTLIB LIB($*)"
	@touch $@

%.clp: qclpsrc/%.clp
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QCLPSRC) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('$<') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QCLPSRC.file/$*.mbr') MBROPT(*REPLACE)"
	liblist -a $(LIBLIST);\
	system $(SYSTEM) "CRTBNDCL PGM($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QCLPSRC)"
	@touch $@

%.cmd: qcmdsrc/%.cmd
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QCMDSRC) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('$<') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QCMDSRC.file/$*.mbr') MBROPT(*REPLACE)"
	system $(SYSTEM) "CRTCMD CMD($(BIN_LIB)/$*) PGM($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QCMDSRC)"
	@touch $@

%.rpg: qrpgsrc/%.rpg
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QRPGSRC) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('$<') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QRPGSRC.file/$*.mbr') MBROPT(*REPLACE)"
	liblist -a $(LIBLIST);\
	system $(SYSTEM) "CRTRPGPGM PGM($(BIN_LIB)/$*)"
	@touch $@

%.dspf: qddssrcd/%.dspf
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QDSPFSRC) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('$<') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QDSPFSRC.file/$*.mbr') MBROPT(*REPLACE)"
	system $(SYSTEM) "CRTDSPF FILE($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QDSPFSRC)"
	@touch $@

%.mnudds: qmnusrc/%.mnudds
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QMNUDDS) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('qmnusrc/$*.mnudds') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QMNUDDS.file/$*.mbr') MBROPT(*REPLACE)"
	system $(SYSTEM) "CRTDSPF FILE($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QMNUDDS)"
	@touch $@

%.mnucmd: qmnusrc/%.mnucmd %.mnudds
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QMNUCMD) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('qmnusrc/$*.mnucmd') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QMNUCMD.file/$*.mbr') MBROPT(*REPLACE)"
	system $(SYSTEM) "CRTMNU MENU($(BIN_LIB)/$*) TYPE(*DSPF) DSPF($(BIN_LIB)/$*)"
	@touch $@

clean:
	rm -f *.rpg *.mnudds *.mnucmd *.dspf *.clp *.cmd
