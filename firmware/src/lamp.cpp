// lamp
// Copyright 2014 by Wiley Cousins, LLC.
// shared under the terms of the MIT License
//
// file: lamp.cpp
// description: application file for the lamp

// avr includes
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

// pin definitions
#include "pindefs.h"

// application includes
#include "lamp.h"

// led serial ISR
ISR(TIMER0_COMPA_vect) {
  // 1 wire serial
  // pulse the data line once to signal data
  PORTD |= (1<<2);
  PORTD &= ~(1<<2);

  // if data is a one, pulse again to signal a 1
  // no pulse is a 0
  if (ledData[byteIndex] & bitIndex) {
    PORTD |= (1<<2);
    PORTD &= ~(1<<2);
  }

  // increment the counters
  bitCount++;
  if (bitCount < 48) {
    if (bitIndex > 1) {
      bitIndex >>= 1;
    }
    else {
      bitIndex = (1<<7);
      byteIndex++;
    }
  }
  else {
    stopTimer();
  }
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

  // find out how many led cards are in each stack
  uint8_t stackSize[NUM_STACKS];
  senseStacks(stackSize);

  // intialize the led data timer
  initTimer();

  // color blending and shit
  // start with just a little red
  uint16_t red = 4000;
  uint16_t grn = 0x0;
  uint16_t blu = 0x0;

  // enable global interrupts
  sei();

  // don't stop believing
  for (;;) {
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

    // set that color and send the data
    set(red, grn, blu, ledData);
    startTimer();

    // BLINK THAT LED LIKE IT'S YOUR JOB
    //PINB |= (1<<1);
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
  bitCount = 0;
  byteIndex = 0;
  bitIndex = (1<<7);
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
    ADCSRA |= (1<<ADEN);
    while (ADCSRA & (1<<ADSC));
    uint8_t read = ADCH;
    // translate it into stack size
    // relation is N = (2560/(256-ADC))-10
    size[i] = 0;
    uint8_t prev;
    int8_t next;
    do {
      prev = read - adcToStackSize[size[i]];
      next = adcToStackSize[size[i]+1] - read;
      if ( next < 0 || prev > next) {
        size[i]++;
      }
    } while (next < 0);
  }
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