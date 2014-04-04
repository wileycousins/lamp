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

#define EFFECT_DEFAULT  0
#define EFFECT_HOLD     1
#define EFFECT_SWIRL    2
#define EFFECT_BLEND    3
#define N_EFFECTS       4

class Effects {
public:
  // Bob the builder
  Effects(Matrix *m);

  // refresh the effect
  // should be called periodically
  refresh(void);

  // actual effects that are available to the public
  // set the default color and brightness
  setDefault(uint8_t *rgb);
  setDefault(uint8_t brite);
  setDefault(uint8_t *rgb, uint8_t brite);

  // set the current effect 
  setEffect(uint8_t effect);
  // get the current effect
  getEffect(uint8_t effect);

private:
  // current effect mode
  bool def;
  bool newMode;
  uint8_t mode;
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
  Matrix *leds;

  // stuff for effects to use
  uint16_t limit;
  uint16_t counter;

  // HEY LOOK EFFECTS ALL THE EFFECTS OH MY GOD PLEASE SAVE US EFFECTS
  void setHold(uint8_t *params, uint8_t nParams);
  void refreshHold(void);
};

#endif