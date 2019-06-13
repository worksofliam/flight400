BIN_LIB=FLIGHT400
BIN_LIB_ILE=$(BIN_LIB)M
SYSTEM=-s

SHELL=/QOpenSys/usr/bin/qsh
LIBLIST=FLGHT400 FLGHT400M

PGM_TARGETS=bcust.rpg bflght.rpg frs000.rpg frs001.rpg frs001.rpg frs001t.rpg \
            frs001u.rpg frs001u2.rpg frs002.rpg frs003.rpg frs004.rpg frs005.rpg \
						frs009.rpg frs021.rpg frs022.rpg frs023.rpg frs024.rpg frs401.rpg \
						frs402.rpg frs401b.rpg frs402.rpg frs402b.rpg frs405.rpg frs406.rpg \
						frs407.rpg frs408.rpg frs409.rpg frs410.rpg frs411.rpg frs412.rpg \
						frs412.rpg gtojcv.rpg rtdofw.rpg rtrand.rpg

all: $(PGM_TARGETS)

%.rpg: qrpgsrc/%.rpg
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QRPGSRC) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('$<') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QRPGSRC.file/$*.mbr') MBROPT(*REPLACE)"
	liblist -a $(LIBLIST);\
	system $(SYSTEM) "CRTRPGPGM PGM($(BIN_LIB)/$*)"
	@touch $@

clean:
	rm -f *.rpg