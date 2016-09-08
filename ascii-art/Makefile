LDFLAGS=-lMagick++-6.Q16 -lMagickWand-6.Q16 -lMagickCore-6.Q16

all: imtest
	./imtest smu.png

imtest.o: imtest.cpp
	g++ `Magick++-config --cppflags` -c -O2 -Wall -o imtest.o imtest.cpp

imtest: imtest.o
	g++ imtest.o `Magick++-config --ldflags` -o imtest
	#g++ imtest.o $(LDFLAGS) -o imtest




