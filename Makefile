PICO_LIBRARY = svoxpico/.libs/libttspico.a 
OPT_FLAG = -O2
SHELL := /bin/bash
LANG_DIR := /usr/share/picotts/lang
DESTDIR := /

all: pico2wave

$(PICO_LIBRARY):
	cd svoxpico; ./autogen.sh && ./configure && make

clean:
	@for file in $(OBJECTS) $(PROGRAM) pico2wave.o pico2wave; do if [ -f $${file} ]; then rm $${file}; echo rm $${file}; fi; done
	@if [ -d $(OBJECTS_DIR) ]; then rmdir $(OBJECTS_DIR) ; fi
	@echo "use \"make clean_all\" to also cleanup svoxpico directory"

clean_all: clean
	cd svoxpico; make clean ; ./clean.sh

pico2wave: $(PICO_LIBRARY)
	gcc -I. -I./svoxpico -Wall -g $(OPT_FLAG) -Dpicolangdir=\"$(LANG_DIR)\" -c -o pico2wave.o src/pico2wave.c
	gcc -I./svoxpico -Wall -g $(OPT_FLAG) pico2wave.o svoxpico/.libs/libttspico.a -o pico2wave -lm -lpopt

install: pico2wave
	mkdir -p $(DESTDIR)/usr/bin
	mkdir -p $(DESTDIR)$(LANG_DIR)
	cp -p pico2wave $(DESTDIR)/usr/bin
	cp -a lang/* $(DESTDIR)$(LANG_DIR)
