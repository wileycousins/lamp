// lamp
// Copyright 2014 by Wiley Cousins, LLC.
// shared under the terms of the MIT License
//
// file: lamp.cpp
// description: application file for the lamp

// avr includes
#include <avr/io.h>
#include <util/delay.h>

// application includes
#include "lamp.h"

// main method
int main(void) {
  // set the heartbeat LED as an output and turn it off
  // heartbeat is on B1
  DDRB |= (1<<1);
  PORTB |= (1<<1);

  // don't stop believing
  for (;;) {
    // BLINK THAT LED LIKE IT'S YOUR JOB
    PINB |= (1<<1);
    _delay_ms(250);
  }
  // hold on to that feeling
  return 42;
}