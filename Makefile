PKG := de/cygx/crow
PKGSOURCES := $(wildcard java/$(PKG)/*.java)
PKGNAMES := $(patsubst java/$(PKG)/%.java,%,$(PKGSOURCES))
SOURCES := java/crow.java $(PKGSOURCES)
CLASSES := $(SOURCES:java/%.java=class/%.class)
GARBAGE := class/*

build: .dummy
jar: crow.jar

realclean: GARBAGE += crow.jar
clean realclean:; rm -rf $(GARBAGE)

crow: class/crow.class
$(PKGNAMES): %: class/$(PKG)/%.class

.dummy: $(SOURCES)
	javac -d class $(SOURCES)
	touch $@

$(CLASSES): class/%.class: java/%.java $(SOURCES)
	javac -sourcepath java -d class $<

crow.jar: $(CLASSES)
	cd class; jar cfe ../$@ crow *
