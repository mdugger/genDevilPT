.PHONY : env clean

CC = g++

ifeq ($(HDDM),yes)
C_FLAGS = -O2  -Wall -fPIC -DWITHHDDM
MISC_LIBS = ../qDevilLib/libqDevil.so \
	$(GLUEX_TOP)/sim-recon/sim-recon/lib/Linux_CentOS6-x86_64-gcc4.4.7/libHDDM.a
INCLUDE = -I../qDevilLib -I$(ROOTSYS)/include -I$(GLUEX_TOP)/sim-recon/sim-recon/include
else
C_FLAGS = -O2  -Wall -fPIC 
MISC_LIBS = ../qDevilLib/libqDevil.so 
INCLUDE = -I../qDevilLib -I$(ROOTSYS)/include
endif

ROOT_LIBS = $(shell root-config --libs) 

LIBS = $(MISC_LIBS) $(ROOT_LIBS)

SOURCES = genDevilPT.cpp
OBJECTS = $(SOURCES:.cpp=.o)
EXECUTABLE = genDevilPT

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(C_FLAGS) $^ -o $@ $(LIBS)

%.o: %.cpp
	$(CC) -c $(C_FLAGS) $(INCLUDE) $<

clean:
	rm -rf $(OBJECTS) $(EXECUTABLE)

env:
	@echo CC = $(CC)
	@echo C_FLAGS = $(C_FLAGS)
	@echo MAIN_FILE = $(MAIN_FILE)
	@echo EXECUTABLE = $(EXECUTABLE)
	@echo SOURCES = $(SOURCES)
	@echo OBJECTS = $(OBJECTS)
	@echo INCLUDE = $(INCLUDE)
	@echo LIBS = $(LIBS)
	@echo HDDMYES = $(HDDMYES)
