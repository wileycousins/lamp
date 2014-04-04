// lamp
// Copyright 2014 by Wiley Cousins, LLC.
// shared under the terms of the MIT License
//
// file: effects.cpp
// description: lamp effects class to interact with the outside world

#include "effects.h"

Effects::Effects(Matrix *m) {
  mode = EFFECT_DEFAULT;
  def = true;
  leds = m;
}

// refresh the effect
void Effects::refresh(void) {
  if (mode != EFFECT_DEFAULT) {
    def = false;
  }
  switch (mode) {
    case EFFECT_HOLD:  refreshHold();  break; 
    // case EFFECT_SWIRL: refreshSwirl(); break;
    // case EFFECT_BLEND: refreshBlend(); break;
    default:
      if (!def) {
        def = true;
        
      }
      break;
    }
  }
}

// set the current effect 
void Effects::setEffect(uint8_t effect, uint8_t *params, uint8_t nParams) {
  switch (effect) {
    // hold effect
    case EFFECT_HOLD:
    mode = EFFECT_HOLD;
    startHold(params, nParams);
    refreshHold();
    break;

    // // swirl effect
    // case EFFECT_SWIRL:
    // mode = EFFECT_SWIRL;
    // startSwirl(params, nParams);
    // refreshSwirl();
    // break;

    // // blend effect
    // case EFFECT_BLEND:
    // mode = EFFECT_BLEND;
    // startBlend(params, nParams);
    // refreshBlend(); 
    // break;

    // default effect
    default:
    mode = EFFECT_DEFAULT;
    uint16_t c[3] = { tenBitValue(defaultColor[0]),
                      tenBitValue(defaultColor[1]),
                      tenBitValue(defaultColor[2])  };
    leds.set(c);
    break;
  }
}

uint8_t Effects::getEffect(void) {
  return mode;
}

uint16_t Effects::tenBitValue(uint8_t eightBit) {
  return tenBitValue(eightBit, defaultBrightness);
}

uint16_t Effects::tenBitValue(uint8_t eightBit, unit8_t b) {
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
void Effects::setDefault(uint8_t brite) {
  if (brite < 1) {
    bright = 1;
  }
  else if (brite > 16) {
    brite = 16;
  }
  defaultBrightness = brite;
  def = false;
}

// set the default color and brightness at the same time
void Effects::setDefault(uint8_t *rgb, uint8_t brite) {
  setDefault(rgb);
  setDefaule(brite);
}


// HEY LOOK EFFECTS ALL THE EFFECTS OH MY GOD PLEASE SAVE US EFFECTS
// HOLD EFFECT
// 4 parameters: R, G, B, time
// 5 parameters: R, G, B, brightness, time
void Effects::startHold(uint8_t *params, uint8_t nParams) {
  counter = 0;
  uint16_t c[3];
  if (nParams == 5) {
    countLimit = (uint16_t)(params[4]) << 4;
    c[0] = tenBitValue(params[0], params[3]);
    c[1] = tenBitValue(params[1], params[3]);
    c[2] = tenBitValue(params[2], params[3]);    
  }
  else if (nParams == 4) {
    countLimit = (uint16_t)(params[3]) << 4;
    c[0] = tenBitValue(params[0]);
    c[1] = tenBitValue(params[1]);
    c[2] = tenBitValue(params[2]);
  }
  leds.set(c);
}

void Effects::refreshHold(void) {
  if (countLimit > 0) {
    if (++counter > countLimit) {
      setEffect(EFFECT_DEFAULT, void, void);
    }
  }
}