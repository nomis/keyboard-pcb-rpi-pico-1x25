# Render PCB as SVG
#
# Dependencies:
# - https://github.com/INTI-CMNB/KiBot
# - https://www.gnu.org/software/m4/
# - https://www.gnu.org/software/sed/

.DELETE_ON_ERROR:

keyboard-pcb-rpi-pico-1x25.svg: \
		keyboard-pcb-rpi-pico-1x25.svg.in \
		build/keyboard-pcb-rpi-pico-1x25-top.bare-svg \
		build/keyboard-pcb-rpi-pico-1x25-bottom.bare-svg Makefile
	m4 < $< > $@

build/keyboard-pcb-rpi-pico-1x25-top.svg build/keyboard-pcb-rpi-pico-1x25-bottom.svg: \
		keyboard-pcb-rpi-pico-1x25.kibot.yaml \
		keyboard-pcb-rpi-pico-1x25.kicad_pcb
	kibot

build/keyboard-pcb-rpi-pico-1x25-%.bare-svg: \
		build/keyboard-pcb-rpi-pico-1x25-%.svg Makefile
	sed \
		-e 's:<!DOCTYPE [^>]\+>::' \
		-e 's:<svg \([^>]*\) width="[^"]*"\([^>]*\)>:<svg \1\2>:' \
		-e 's:<svg \([^>]*\) height="[^"]*"\([^>]*\)>:<svg \1\2>:' \
		-e 's:<svg ::' \
		< $< > $@
