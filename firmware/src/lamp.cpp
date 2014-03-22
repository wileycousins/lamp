// lamp
// Copyright 2014 by Wiley Cousins, LLC.
// shared under the terms of the MIT License
//
// file: lamp.cpp
// description: application file for the lamp

// avr includes
#include <stdlib.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

// pin definitions
#include "pindefs.h"

// application includes
#include "lamp.h"

// led serial ISR
ISR(TIMER0_COMPA_vect) {
  //if (!wait) {
    // 1 wire serial
    // pulse the data line once to signal data
    PORTD |= (1<<2);
    PORTD &= ~(1<<2);

    // if data is a one, pulse again to signal a 1
    // no pulse is a 0
    if (currentStackData[byteIndex] & bitIndex) {
      PORTD |= (1<<2);
      PORTD &= ~(1<<2);
    }

    // increment counters
    bitIndex >>= 1;
    if (bitIndex == 0) {
      if (byteIndex < 5) {
        bitIndex = (1<<7);
        byteIndex++;
      }
      else {
        stopTimer();
      }
    }
    //else {
    //  cardCount++;
    //  // more cards to program
    //  if (cardCount < currentStackSize) {
    //    wait = true;
    //    waitCount = 0;
    //    currentStackData += 6;
    //  }
      // no more cards to program
      //else {
      //  stopTimer();
      //}
    // }
  //}
  //// stop waiting if it's been long enough
  //else if (++waitCount > LED_WAIT_COUNT) {
  //  wait = false;
  //  byteIndex = 0;
  //  bitIndex = (1<<7);
  //}
}

// main method
int main(void) {
  // diable global interrupts
  cli();

  // set the heartbeat LED as an output and turn it off
  // heartbeat is on B1
  DDRB |= (1<<1);
  PORTB |= (1<<1);

  // set stack 0 serial data to output and pull it low
  DDRD |= (1<<2);
  PORTD &= ~(1<<2);

  // init all other pins to inputs with pullups
  initUnusedPins();

  // find out how many led cards are in each stack, and create data arrays for each
  uint8_t *stack[NUM_STACKS];
  uint8_t stackSize[NUM_STACKS];
  senseStacks(stackSize);
  for (uint8_t i=0; i<NUM_STACKS; i++) {
    if (stackSize[i] > 0) {
      stack[i] = initDataArray(stackSize[i]);
    }
  }

  // intialize the led data timer
  initTimer();

  // color blending and shit
  // start with just a little red
  //uint16_t red = 1000;
  //uint16_t grn = 0x0;
  //uint16_t blu = 0x0;

  //if (stackSize[0] >= 1) {
    set(500, 0, 0, 0, stack[0]);
  //}
  //if (stackSize[0] >= 2) {
  //  set(0, 500, 0, 1, stack[0]);
  //}
  //if (stackSize[0] >= 3) {
  //  set(0, 0, 500, 2, stack[0]);
  //}

  // enable global interrupts
  sei();

  //if (stackSize[0]) {
    // for testing, set ledData to stack0 data
    currentStackData = stack[0];
    currentStackSize = stackSize[0];
    startTimer();
  //}

  // don't stop believing
  for (;;) {
    /*
    if (!blu && red) {
      red -= 50;
      grn += 50;
    }
    else if (!red && grn) {
      grn -= 50;
      blu += 50;
    }
    else if (!grn && blu) {
      blu -= 50;
      red += 50;
    }
    */

    // set that color and send the data
    //set(red, grn, blu, ledData);
    //set(red, grn, blu, 0, stack[0]);
    //startTimer();

    // BLINK THAT LED LIKE IT'S YOUR JOB
    PINB |= (1<<1);
    _delay_ms(100);
  }
  // hold on to that feeling
  return 42;
}

void initTimer(void) {
  // use 8 bit timer 0
  // looking for f = 230.4 kHz
  // set to CTC mode with prescaler at 64 and top at 1 
  TCCR0A = (1<<WGM01);
  TCCR0B = ( (1<CS01) | (1<<CS00) );
  OCR0A = 1;
}

void startTimer(void) {
  // reset the data indices
  cardCount = 0;
  byteIndex = 0;
  bitIndex = (1<<7);
  // reset the wait flag
  wait = false;
  // enable the interrupt
  TIMSK0 = (1<<OCIE0A);
}

void stopTimer(void) {
  TIMSK0 = 0;
}

void set(uint16_t red, uint16_t grn, uint16_t blu, uint8_t *d) {
  d[0] = 0x3A;
  d[1] = (0xA0 | (red >> 8));
  d[2] = (red & 0xFF);
  d[3] = (grn >> 4);
  d[4] = (((grn<<4) & 0xF0) | (blu >> 8));
  d[5] = (blu & 0xFF);
}

// set led color of a certain led in a certain stack
void set(uint16_t red, uint16_t grn, uint16_t blu, uint8_t led, uint8_t *data) {
  uint8_t *d = data + 6*led;
  d[0] = 0x3A;
  d[1] = (0xA0 | (red >> 8));
  d[2] = (red & 0xFF);
  d[3] = (grn >> 4);
  d[4] = (((grn<<4) & 0xF0) | (blu >> 8));
  d[5] = (blu & 0xFF);
}

// initialize analog inputs and sense stack sizes
void senseStacks(uint8_t *size) {
  // analog inputs on D2, D3, D4, so diable digital input on these pins
  DIDR0 = ( (1<<ADC4D) | (1<<ADC3D) | (1<<ADC2D) );
  // reference voltage is AVcc, external capacitor on AREF
  // left adjust result because we only need 8 bits
  // set first read to 1.1V reference voltage (MUX3..0 = 0xE)
  ADMUX = ( (1<<ADLAR) | (1<<REFS0) | (0xE) );
  // divide sysclock by 128 to set fadc to ~100kHz
  // enable the ADC and start a conversion to warm everything up
  ADCSRA = ( (1<<ADEN) | (1<<ADSC) | (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0) );
  // wait for that conversion to complete
  while (ADCSRA & (1<<ADSC));

  // read the stack sizes
  for (uint8_t i=0; i<NUM_STACKS; i++) {
    // set ADC input to correct input
    ADMUX = ((ADMUX & ~0xF) | (2+i));
    // take the reading
    ADCSRA |= (1<<ADSC);
    while (ADCSRA & (1<<ADSC));
    uint8_t read = ADCH;
    // translate it into stack size
    size[i] = 0;
    if (read > adcToStackSize[MAX_STACK_SIZE]) {
      size[i]++;
      uint8_t prev;
      int8_t next;
      do {
        prev = adcToStackSize[size[i]] - read;
        next = read - adcToStackSize[size[i]+1];
        if ( next < 0 || prev > next) {
          size[i]++;
        }
      } while (next < 0);
    }
  }
}

uint8_t *initDataArray(uint8_t stackSize) {
  stackSize *= 6;
  // calloc malloc's and initializes elements to 0
  return (uint8_t *)(calloc(stackSize, sizeof(uint8_t)));
}

// initialize unused pins to inputs with internal pullups activated
void initUnusedPins(void) {
  // portb unused pins
  DDRB &= ~PORTB_UNUSED_MASK;
  PORTB |= PORTB_UNUSED_MASK;

  // portc unused pins
  DDRC &= ~PORTC_UNUSED_MASK;
  PORTC |= PORTC_UNUSED_MASK;

  // portd unused pins
  DDRD &= ~PORTD_UNUSED_MASK;
  PORTD |= PORTD_UNUSED_MASK;
}