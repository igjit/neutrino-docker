NEUTRINO_VER = NEUTRINO-MAIN-Linux_v0.103
KIRITAN_VER = NEUTRINO-KIRITAN_v0.10

MUSICXMLS = $(wildcard NEUTRINO/score/musicxml/*.musicxml)
WAVS = $(subst NEUTRINO/score/musicxml/,NEUTRINO/output/,$(MUSICXMLS:.musicxml=_syn.wav))

wav: $(WAVS)

build:
	bin/build.sh

kiritan: NEUTRINO NEUTRINO/model/KIRITAN

NEUTRINO:
	wget https://n3utrino.work/downloads/$(NEUTRINO_VER).zip
	unzip $(NEUTRINO_VER).zip
	chmod +x NEUTRINO/bin/*

NEUTRINO/model/KIRITAN:
	wget http://ftp.vector.co.jp/72/53/2252/$(KIRITAN_VER).zip
	unzip $(KIRITAN_VER).zip
	cp -r NEUTRINO-*/KIRITAN NEUTRINO/model/

NEUTRINO/output/%_syn.wav: NEUTRINO/score/musicxml/%.musicxml
	bin/neutrino.sh -n $(notdir $(basename $^)) -s play

.PHONY: wav build kiritan
