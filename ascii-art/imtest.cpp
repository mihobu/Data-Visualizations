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

  Image img;                  // data object for our loaded image
  unsigned int row, col;      // iterate over image pixels
  // characters to represent 10 levels of gray
  //
  // This is a convincing sequence (paulbourke.net/dataformats/asciiart)
  // char dot[10] = { ' ', '.', ':', '-', '=', '+', '*', '#', '%', '@' };
  //
  // but this sequence is even more convincing:
  // (from http://larc.unt.edu/ian/art/ascii/shader)
  char dot[10] = { ' ', '.', ':', '*', '|', 'V', 'F', 'N', 'M', '@' };

  ColorGray pix1, pix2;       // objects to store pixel color info
  int shade;                  // the shade scaled to the range 0..9
  char *fname = argv[1];      // file name of the image to load

  InitializeMagick(*argv);    // Major credit card to get us started

  try {
    img.read(fname);          // Load the image into memory 
  }
  catch(Exception &error_) {  // what to do if things go south
    cout << "Caught exception: " << error_.what() << endl;
    return(1);                // bail
  }

  // What have we learned?
  cout << "The image is " << img.columns() << " by " << img.rows() << endl;

  // visit every pixel in every OTHER row
  for ( row = 0 ; row < img.rows() ; row+=2 ) {
    for ( col = 0 ; col < img.columns() ; col++ ) {
      // Since terminal characters tend to be taller than they are wide,
      // we'll average the pixels from two rows and convert that averaged
      // value to a character. That way, our rendered ASCII art doesn't
      // appear stretched out vertically.
      pix1 = ColorGray(img.pixelColor(col,row));
      pix2 = ColorGray(img.pixelColor(col,row+1));
      shade = 9 - round( ((pix1.shade()+pix2.shade())/2) * 9);
      cout << dot[shade];     // output the character for this dot
    }
    cout << "\n";             // newline after each row
  }

  cout << "Good night, Gracie!";             // Say good night, Gracie
  return(0);
}
