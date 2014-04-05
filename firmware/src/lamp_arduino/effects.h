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
#define EFFECT_RAINBOW  3
#define N_EFFECTS       4

class Effects {
public:
  // Bob the builder
  Effects(Matrix *m, uint8_t *rgb, uint8_t br);

  // refresh the effect
  // should be called periodically
  void refresh(void);

  // actual effects that are available to the public
  // set the default color and brightness
  void setDefault(uint8_t *rgb);
  void setDefault(uint8_t bright);
  void setDefault(uint8_t *rgb, uint8_t bright);

  // set the current effect 
  void setEffect(uint8_t effect, uint8_t *rgb, uint8_t time);
  void setEffect(uint8_t effect, uint8_t *rgb, uint8_t time, uint8_t bright);
  // get the current effect
  uint8_t getEffect(void);

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
  uint16_t tenBitValue(uint8_t eightBitValue, uint8_t b);

  // stack strucure and data
  Matrix *leds;

  // stuff for effects to use
  bool fxFlag;
  uint16_t limit;
  uint16_t counter;

  // HEY LOOK EFFECTS ALL THE EFFECTS OH MY GOD PLEASE SAVE US EFFECTS
  
  // hold - holds a color for a certain time (0 = forever) then drops back to the default
  void startHold(uint8_t *rgb, uint8_t t, uint8_t br);
  void refreshHold(void);

  // swirl - like a flushing toilet, but with colors
  void startSwirl(uint8_t *rgb, uint8_t t, uint8_t br);
  void refreshSwirl(void);

  // rainbow - great for demo
  void startRainbow(uint8_t t, uint8_t br);
  void refreshRainbow(void);
};

#endif