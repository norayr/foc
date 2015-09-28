
SETPATH = MODULES=".:x86_64:rtl"

VOC0 = $(SETPATH) /opt/voc/bin/voc

all:
	#$(VOC0) -s ORS.Mod
	#$(VOC0) -s ORB.Mod
	#$(VOC0) -s ORG.Mod
	$(VOC0) -s CompatFiles.Mod \
	        Fonts.Mod CompatTexts.Mod Oberon.Mod \
	        OS.Mod OB.Mod OG.Mod OP.Mod -M

test:
	./OP -s test.Mod

clean:
	rm *.sym
	rm *.o
	rm *.h
	rm *.c

