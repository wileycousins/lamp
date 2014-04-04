// lamp
// Copyright 2014 by Wiley Cousins, LLC.
// shared under the terms of the MIT License
//
// file: matrix.h
// description: header file for the lamp LED matrix class
//   The LED matrix allocates the necessary arrays and provides methods for 
//   changing LED colors in those arrays

#ifndef LAMP_MATRIX_H
#define LAMP_MATRIX_H

// includes necessary for this header
#include <stdint.h>

// number of led stacks in the lamp
#define MATRIX_NUM_STACKS 3

class Matrix {
public:
  // constructor
  // takes in how large each of the stacks are
  Matrix(uint8_t *sizes);
  
  // series of set methods
  // with just an rgb array as the param, it sets all LEDs
  void set(uint16_t *rgb);
  // with an rgb value, a stack, and a level, it'll set an individual card
  void set(uint8_t *rgb, uint8_t s, uint8_t c);
  // separate methods for setting whole stacks or levels
  void setStack(uint16_t *rgb, uint8_t s);
  void setLevel(uint16_t *rgb, uint8_t c);
  
  // get the information of a card
  void get(uint16_t *rgb, uint8_t s, uint8_t c);


private:
  // where the magic happens (TRIPLE POINTER WHAT UP)
  // three dimensional array that is allocated in the matrix constructor
  // first dimension is the stacks
  // second dimension is the cards in the stacks
  // third dimension is the rgb values of each card
  uint16_t ***m;
  // place to hold stack sizes
  uint8_t stackSize[MATRIX_NUM_STACKS];

  // allocate that matrix triple pointer
  void allocateMatrix(void);

};

#endif