// lamp
// Copyright 2014 by Wiley Cousins, LLC.
// shared under the terms of the MIT License
//
// file: effects.cpp
// description: lamp effects class to interact with the outside world

#include <stdlib.h>
#include "effects.h"

Effects::Effects(Matrix *m, uint8_t *rgb, uint8_t br) {
  mode = EFFECT_DEFAULT;
  def = true;
  leds = m;

  setDefault(rgb, br);

  setEffect(EFFECT_DEFAULT, (uint8_t*)NULL, 0);
}

// refresh the effect
void Effects::refresh(void) {
  switch (mode) {
    case EFFECT_HOLD:
    refreshHold();
    break;

    case EFFECT_SWIRL:
    refreshSwirl();
    break;

    case EFFECT_RAINBOW:
    refreshRainbow();
    break;
  }
}

// set the current effect 
// use default brightness
void Effects::setEffect(uint8_t effect, uint8_t *rgb, uint8_t t) {
  setEffect(effect, rgb, t, defaultBrightness);
}
// use explicit brightness
void Effects::setEffect(uint8_t effect, uint8_t *rgb, uint8_t t, uint8_t b) {
  switch (effect) {
    // hold effect
    case EFFECT_HOLD:
    mode = EFFECT_HOLD;
    startHold(rgb, t, b);
    refreshHold();
    break;

    // swirl effect
    case EFFECT_SWIRL:
    mode = EFFECT_SWIRL;
    startSwirl(rgb, t, b);
    refreshSwirl();
    break;

    // rainbow
    case EFFECT_RAINBOW:
    mode = EFFECT_RAINBOW;
    startRainbow(t, b);
    refreshRainbow(); 
    break;

    // default effect
    default:
    mode = EFFECT_DEFAULT;
    uint16_t c[3] = { tenBitValue(defaultColor[0]),
                      tenBitValue(defaultColor[1]),
                      tenBitValue(defaultColor[2])  };
    leds->set(c);
    break;
  }
}

uint8_t Effects::getEffect(void) {
  return mode;
}

uint16_t Effects::tenBitValue(uint8_t eightBit) {
  return tenBitValue(eightBit, defaultBrightness);
}

uint16_t Effects::tenBitValue(uint8_t eightBit, uint8_t b) {
  return (uint16_t)(eightBit) * b;
}

// set the default color
void Effects::setDefault(uint8_t *rgb) {
  defaultColor[0] = rgb[0];
  defaultColor[1] = rgb[1];
  defaultColor[2] = rgb[2];
  def = false;
}

// set the efault brightness
void Effects::setDefault(uint8_t bright) {
  if (bright < 1) {
    bright = 1;
  }
  else if (bright > 16) {
    bright = 16;
  }
  defaultBrightness = bright;
  def = false;
}

// set the default color and brightness at the same time
void Effects::setDefault(uint8_t *rgb, uint8_t bright) {
  setDefault(rgb);
  setDefault(bright);
}


// HEY LOOK EFFECTS ALL THE EFFECTS OH MY GOD PLEASE SAVE US EFFECTS
// HOLD EFFECT
void Effects::startHold(uint8_t *rgb, uint8_t t, uint8_t brightness) {
  counter = 0;
  uint16_t c[3];
  limit = (uint16_t)(t) << 4;
  
  c[0] = tenBitValue(rgb[0], brightness);
  c[1] = tenBitValue(rgb[1], brightness);
  c[2] = tenBitValue(rgb[2], brightness);    

  leds->set(c);
}

void Effects::refreshHold(void) {
  if (limit > 0) {
    if (++counter > limit) {
      setEffect(EFFECT_DEFAULT, (uint8_t*)NULL, 0);
    }
  }
}

// swirl - like a flushing toilet, but with colors
void Effects::startSwirl(uint8_t *rgb, uint8_t t, uint8_t br) {
  counter = 0;
  limit = t;
  fxFlag = false;
  // zero out all the LEDs
  leds->clear();
  // set each stack to one of the colors
  for (uint8_t s=0; s<MATRIX_NUM_STACKS; s++) {
    leds->setStack(tenBitValue(rgb[s], br), s, RED+s);
  }
}

void Effects::refreshSwirl(void) {
  // if stack 0 has red and not blue, then we're in the first part of the swirl
  if (leds->get(0, 0, RED) && !leds->get(0, 0, BLU)) {
    // if fx flag has been thrown, the effect is over
    if (!fxFlag) {
      // stack 0
      leds->setStack(leds->get(0, 0, RED)-limit, 0, RED);
      leds->setStack(leds->get(0, 0, GRN)+limit, 0, GRN);
      // stack 1
      leds->setStack(leds->get(1, 0, GRN)-limit, 1, GRN);
      leds->setStack(leds->get(1, 0, BLU)+limit, 1, BLU);
      // stack 2
      leds->setStack(leds->get(2, 0, BLU)-limit, 2, BLU);
      leds->setStack(leds->get(2, 0, RED)+limit, 2, RED);
    }
    else {
      // return to default
      setEffect(EFFECT_DEFAULT, (uint8_t*)NULL, 0);
    }
  }
  // if stack 2 has red and not blue, then we're in the second part
  else if (leds->get(2, 0, RED) && !leds->get(2, 0, BLU)) {
    // stack 2
    leds->setStack(leds->get(2, 0, RED)-limit, 2, RED);
    leds->setStack(leds->get(2, 0, GRN)+limit, 2, GRN);
    // stack 0
    leds->setStack(leds->get(0, 0, GRN)-limit, 0, GRN);
    leds->setStack(leds->get(0, 0, BLU)+limit, 0, BLU);
    // stack 1
    leds->setStack(leds->get(1, 0, BLU)-limit, 1, BLU);
    leds->setStack(leds->get(1, 0, RED)+limit, 1, RED);
  }
  // if stack 1 has red and not blue, then we're in the third part
  else if (leds->get(1, 0, RED) && !leds->get(1, 0, BLU)) {
    fxFlag = true;
    // stack 1
    leds->setStack(leds->get(1, 0, RED)-limit, 1, RED);
    leds->setStack(leds->get(1, 0, GRN)+limit, 1, GRN);
    // stack 2
    leds->setStack(leds->get(2, 0, GRN)-limit, 2, GRN);
    leds->setStack(leds->get(2, 0, BLU)+limit, 2, BLU);
    // stack 0
    leds->setStack(leds->get(0, 0, BLU)-limit, 0, BLU);
    leds->setStack(leds->get(0, 0, RED)+limit, 0, RED);
  }
}

void Effects::startRainbow(uint8_t t, uint8_t br) {
  limit = t;
  uint16_t rgb[3];
  rgb[0] = tenBitValue(255, br);
  rgb[1] = 0;
  rgb[2] = 0;
  leds->set(rgb);
}

void Effects::refreshRainbow(void) {
  int16_t rgb[3];
  rgb[0] = leds->get(0, 0, RED);
  rgb[1] = leds->get(0, 0, GRN);
  rgb[2] = leds->get(0, 0, BLU);


  if ((rgb[0]>0) && (rgb[2]<=0)) {
    rgb[0] -= limit;
    rgb[1] += limit;
  }
  else if ((rgb[1]>0) && (rgb[0]<=0)) {
    rgb[1] -= limit;
    rgb[2] += limit;
  }
  else if ((rgb[2]>0) && (rgb[1]<=0)) {
    rgb[2] -= limit;
    rgb[0] += limit;
  }

  uint16_t colors[3];
  if (rgb[0] >= 0) {
    colors[0] = (uint16_t)(rgb[0]);
  }
  else {
    colors[0] = 0;
  }
  if (rgb[1] >= 0) {
    colors[1] = (uint16_t)(rgb[1]);
  }
  else {
    colors[1] = 0;
  }
  if (rgb[2] >= 0) {
    colors[2] = (uint16_t)(rgb[2]);
  }
  else {
    colors[2] = 0;
  }
  leds->set(colors);
}
