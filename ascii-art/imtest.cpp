/*****************************************************************************
 imtest.cpp - a very crude little program that converts an image file
              into ASCII "art"
 by Michael Burkhardt (mburkhardt@smu.edu)
 September 7, 2016 for MSDS 6391 Data Visualization II
 *****************************************************************************/

#include <Magick++.h>
#include <iostream>

using namespace std;
using namespace Magick;

int main(int argc,char **argv) {
  Image img;
  unsigned int row, col; // iterate over image pixels
  char dot[10] = {' ', '.', ':', '-', '=', '+', '*', '#', '%', '@' }; // 10 levels of gray
  ColorGray pix1, pix2;
  int shade;
  char *fname = argv[1];

  InitializeMagick(*argv);

  // Load the image into memory
  try {
    //img.read("smu.png");
    img.read(fname);
  }
  catch(Exception &error_) {
    cout << "Caught exception: " << error_.what() << endl;
    return(1);
  }

  // What have we learned?
  cout << "The image is " << img.columns() << " by " << img.rows() << endl;

  for ( row = 0 ; row < img.rows() ; row+=2 ) {
    for ( col = 0 ; col < img.columns() ; col++ ) {
      pix1 = ColorGray(img.pixelColor(col,row));
      pix2 = ColorGray(img.pixelColor(col,row+1));
      //shade = 9 - round(pix.shade() * 9);
      shade = 9 - round( ((pix1.shade()+pix2.shade())/2) * 9);
      //cout << "[" << row << "," << col << "] = " << shade << endl;
      cout << dot[shade];
    }
    cout << "\n";
  }

  // Say goodbye
  cout << "Bye!";
  return(0);
}
