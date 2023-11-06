# tool
CURL = curl -L -o
DC   = dmd
RUN  = dub run --compiler=$(DC)

# src
D += $(wildcard src/*.d*)

# all
.PHONY: all
all: $(D)
	$(RUN)

# format
format: tmp/format_d
tmp/format_d: $(D)
	$(RUN) dfmt -- -i $? && touch $@

# doc
.PHONY: doc
doc: doc/CRL-90-8.pdf doc/xlib.pdf

doc/CRL-90-8.pdf:
	$(CURL) $@ http://www.hpl.hp.com/techreports/Compaq-DEC/CRL-90-8.pdf
doc/xlib.pdf:
	$(CURL) $@ https://www.x.org/docs/X11/xlib.pdf

# install
APT_SRC = /etc/apt/sources.list.d
ETC_APT = $(APT_SRC)/d-apt.list $(APT_SRC)/llvm.list
.PHONY: install update doc gz
install: doc gz $(ETC_APT)
	sudo apt update && sudo apt --allow-unauthenticated install -yu d-apt-keyring
	dub fetch dfmt
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -yu `cat apt.txt`
$(APT_SRC)/%: tmp/%
	sudo cp $< $@
tmp/d-apt.list:
	$(CURL) $@ http://master.dl.sourceforge.net/project/d-apt/files/d-apt.list

gz:
