// lamp
// Copyright 2014 by Wiley Cousins, LLC.
// shared under the terms of the MIT License
//
// file: effects.h
// description: header file for the lamp effects class

#ifndef LAMP_EFFECTS_H
#define LAMP_EFFECTS_H

#include <stdint.h>
#include "matrix.h"

class Effects {
public:
  // Bob the builder
  Effects(void);

  // actual effects that are available to the public
  // set the default color and brightness
  setDefault(uint8_t *rgb);
  setDefault(uint8_t brite);
  setDefault(uint8_t *rgb, uint8_t brite);

  // swirl around the 


private:
  // default color
  uint8_t defaultColor[3];
  // brightness (1-16)
  // multiplied by 8 bit color values to get 10 bit colors
  // default is set in constructor
  uint8_t defaultBrightness;

  // get a ten bit r, g, or b value given a 8 bit value and the brightness
  // use default brightness
  uint16_t tenBitValue(uint8_t eightBitValue);
  // use a different birghtness
  uint16_t tenBitValue(uint8_t eightBitValue, unit8_t b);

  // stack strucure and data
  Matrix leds;
};

#endif