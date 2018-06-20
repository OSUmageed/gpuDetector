
MPICXX		:=$(shell which mpicxx)
NVCC    	:=$(shell which nvcc)
CXX 		:=g++

MKDIR   	= mkdir -p
BINDIR 		= ./bin
INCP 		= /usr/local/cuda/include
# LIBS	= -lib
LIBMPI  	:=-lmpi 
LIBCUDA         :=-lcudart -lcuda

.PHONY: clean install testi test runtest runtesti

all: $(BINDIR) $(BINDIR)/libgpudetect.a

$(BINDIR):
	$(MKDIR) $(BINDIR)

$(BINDIR)/gpudetect.o: gpuDetector.cpp gpuDetector.h
	$(CXX) -c gpuDetector.cpp -o $@ -I$(INCP)

$(BINDIR)/libgpudetect.a: $(BINDIR)/gpudetect.o
	ar crf $@ $< #$(LIBCUDA)

test: example.cpp $(BINDIR)/libgpudetect.a
	$(NVCC) example.cpp -L$(BINDIR) -lgpudetect -o $(BINDIR)/test $(LIBMPI)

testi: example.cpp $(BINDIR)
	$(NVCC) example.cpp -lgpudetect -o $(BINDIR)/testi $(LIBMPI)
	@echo Success!
	@echo Delete executable if you like

runtest: test
	@echo -------- Local --------- 
	mpirun -np 6 ./bin/test

runtesti: testi
	@echo -------- Installed -----
	mpirun -np 6 ./bin/testi
	@echo BACK TO MAKEFILE
	@echo Success!
	@echo Delete local executable if you like

clean:
	rm -rf $(BINDIR)

install: $(BINDIR)/libgpudetect.a 
	cp $< /usr/lib/libgpudetect.a
	cp gpuDetector.h /usr/include/gpuDetector.h
	make clean
	@echo Installed gpuDetector, cleaned local bin
