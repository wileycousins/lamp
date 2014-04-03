// lamp
// Copyright 2014 by Wiley Cousins, LLC.
// shared under the terms of the MIT License
//
// file: matrix.h
// description: LED matrix class
//   The LED matrix allocates the necessary arrays and provides methods for
//   changing LED colors in those arrays

#include <stdlib.h>
#include "matrix.h"

// constructor saves the stack sizes and calls the allocate function
Matrix::Matrix(uint8_t* sizes) {
  for (uint8_t i; i<MATRIX_NUM_STACKS; i++) {
    stackSize[i] = sizes[i];
  }
  allocateMatrix();
}

// allocates the 3D matrix of LEDs properly
void Matrix::allocateMatrix(void) {
  // first level is the number of stacks
  m = (uint16_t***)(malloc(MATRIX_NUM_STACKS * sizeof(uint16_t**)));
  for (uint8_t stack=0; stack<MATRIX_NUM_STACKS; stack++) {
    m[stack] = (uint16_t*)(malloc(stackSize[stac] * sizeof(uint16_t*)));
    // second level is the number of cards in that stack
    for (uint8_t card=0; card<stackSize[stack]; card++) {
      // third level is the rgb values for each card
      m[stack][card] = (uint16_t*)(malloc(3*sizeof(uint16_t)));
      // set each value to zero by default
      for (uint8_t color=0; color<3; color++) {
        m[stack][card][color] = 0;
      }
    }
  }
}