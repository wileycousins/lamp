// avr includes
#include <stdlib.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

// application includes
//#include "matrix.h"
#include "effects.h"

// led stacks
#define NUM_STACKS  3
#define LED_WAIT_COUNT  4

// unused pins
#define PORTB_UNUSED_MASK  ( (1<<2) | (1<<0) )
#define PORTC_UNUSED_MASK  ( (1<<5) | (1<<1) | (1<<0) )
#define PORTD_UNUSED_MASK  ( (1<<7) | (1<<6) | (1<<5) )

// global objects
uint8_t currentStack;
uint8_t *currentStackData;
uint8_t currentStackSize;
volatile uint8_t cardCount;
volatile uint8_t byteIndex;
volatile uint8_t bitIndex;
volatile bool wait;
volatile uint8_t waitCount;

#define MAX_STACK_SIZE 10
uint8_t adcToStackSize[MAX_STACK_SIZE+1] = {
  0, 232, 213, 196, 182, 170, 160, 150, 142, 134, 128
};

// main method
int main(void) {
  // serial
  Serial.begin(19200);
  //Serial.println("i love lamp");
  
  // disable global interrupts
  cli();

  // set the heartbeat LED as an output and turn it off
  // heartbeat is on B1
  DDRB |= (1<<1);
  PORTB |= (1<<1);

  // set stack serial data pins to output and pull them low
  for (uint8_t i=0; i<NUM_STACKS; i++) {
    DDRD |= (1<<(2+i));
    PORTD &= ~(1<<(2+i));
  }

  // init all other pins to inputs with pullups
  initUnusedPins();

  // find out how many led cards are in each stack, and create data arrays for each
  uint8_t *stackData[NUM_STACKS];
  uint8_t stackSize[NUM_STACKS];
  senseStacks(stackSize);
  // allocate the LED matrix
  Matrix leds(stackSize);

  for (uint8_t i=0; i<NUM_STACKS; i++) {
    if (stackSize[i] > 0) {
      stackData[i] = initDataArray(stackSize[i]);
    }
  }

  // intialize the led data timer
  initTimer();

  // color blending and shit
  // uint16_t red = 0;
  // uint16_t grn = 0;
  // uint16_t blu = 0;
  // uint8_t dr = 0;
  // uint8_t dg = 0;
  // uint8_t db = 0;


  // enable global interrupts
  sei();

  if (stackSize[0]) {
    // for testing, set ledData to stack0 data
    currentStack = 0;
    currentStackData = stackData[0];
    currentStackSize = stackSize[0];
    //startTimer();
  }

  // all red for test
  uint16_t rgb[3] = {1000, 0, 0};
  leds.set(rgb);

  for (uint8_t s=0; s<MATRIX_NUM_STACKS; s++) {
    leds.get(rgb, s, 0);
    set(rgb[0], rgb[1], rgb[2], 0, stackData[s]);
  }

  // color
  // uint16_t color[3] = {0, 0, 0};
  // uint8_t diff[3] = {0, 0, 0};

  // uint8_t loopCounter = 0;
  // uint8_t shiftCounter = 12;
  // don't stop believing
  for (;;) {
    // // leds
    // //uint16_t led0[3] = {4000, 4000, 4000};
    // //uint16_t led1[3] = {4000, 4000, 4000};
    // //uint16_t led2[3] = {4000, 4000, 4000};
    
    // if timer is not currently going, send data to next stack
    if (!TIMSK0) {
      currentStack = (currentStack < 2) ? (currentStack+1) : 0;
      currentStackData = stackData[currentStack];
      currentStackSize = stackSize[currentStack];
      startTimer();
    }

    // // get color data from serial
    // if (Serial.available() >= 3) {
    //   color[0] = Serial.read();
    //   color[1] = Serial.read();
    //   color[2] = Serial.read();
    //   // clear out the buffer just in case
    //   while (Serial.available()) {
    //     Serial.read();
    //   }
      
    //   // get the differences (1 / 4th)
    //   diff[0] = (uint8_t)(color[0]);
    //   diff[1] = (uint8_t)(color[1]);
    //   diff[2] = (uint8_t)(color[2]);
      
    //   // shift numbers to 10 bit
    //   color[0] <<= 2;
    //   color[1] <<= 2;
    //   color[2] <<= 2;
      
    //   // initialize the leds
    //   shiftCounter = 0;
      
    //   uint16_t card0[3] = {color[0], 0, 0};
    //   uint16_t card1[3] = {0, color[1], 0};
    //   uint16_t card2[3] = {0, 0, color[2]};

    //   leds.set(card0, 0, 0);
    //   leds.set(card1, 1, 0);
    //   leds.set(card2, 2, 0);
    // }
    
    // // ever ten loops, recalculate the color
    // if (++loopCounter > 10) {
    //   loopCounter = 0;
      
    //   // calculate new colors
    //   if (shiftCounter < 4) {
    //     card0[0] = red - (shiftCounter * dr);
    //     card0[1] = 0;
    //     card0[2] = shiftCounter * db;
        
    //     card1[0] = shiftCounter * dr;
    //     card1[1] = grn - (shiftCounter * dg);
    //     card1[2] = 0;
        
    //     card2[0] = 0;
    //     card2[1] = shiftCounter * dg;
    //     card2[2] = blu - (shiftCounter * db);
    //   }
    //   else if (shiftCounter < 8) {
    //     card1[0] = red - ((shiftCounter-4) * dr);
    //     card1[1] = 0;
    //     card1[2] = (shiftCounter-4) * db;
        
    //     card2[0] = (shiftCounter-4) * dr;
    //     card2[1] = grn - ((shiftCounter-4) * dg);
    //     card2[2] = 0;
        
    //     card0[0] = 0;
    //     card0[1] = (shiftCounter-4) * dg;
    //     card0[2] = blu - ((shiftCounter-4) * db);
    //   }
    //   else if (shiftCounter < 12) {
    //     card2[0] = red - ((shiftCounter-8) * dr);
    //     card2[1] = 0;
    //     card2[2] = (shiftCounter-8) * db;
        
    //     card0[0] = (shiftCounter-8) * dr;
    //     card0[1] = grn - ((shiftCounter-8) * dg);
    //     card0[2] = 0;
        
    //     card1[0] = 0;
    //     card1[1] = (shiftCounter-8) * dg;
    //     card1[2] = blu - ((shiftCounter-8) * db);
    //   }
    //   else {
    //     led0[0] = 4000;
    //     led0[1] = 4000;
    //     led0[2] = 4000;
      
    //     led1[0] = 4000;
    //     led1[1] = 4000;
    //     led1[2] = 4000;
      
    //     led2[0] = 4000;
    //     led2[1] = 4000;
    //     led2[2] = 4000;
    //   }
      
    //   // increment counter if necessary
    //   if (shiftCounter < 12) {
    //     shiftCounter++;
    //   }
      
    //   // set the data
    //   set(led0[0], led0[1], led0[2], 0, stack[0]);
    //   set(led1[0], led1[1], led1[2], 0, stack[1]);
    //   set(led2[0], led2[1], led2[2], 0, stack[2]);

      // // BLINK THAT LED LIKE IT'S YOUR JOB
      // PINB |= (1<<1);
    // }
    // slight delay
    _delay_ms(10);
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

// led serial ISR
ISR(TIMER0_COMPA_vect) {
  if (currentStackSize && !wait) {
    // 1 wire serial
    // pulse the data line once to signal data
    PORTD |= (1<<(2+currentStack));
    PORTD &= ~(1<<(2+currentStack));

    // if data is a one, pulse again to signal a 1
    // no pulse is a 0
    if (currentStackData[byteIndex] & bitIndex) {
      PORTD |= (1<<(2+currentStack));
      PORTD &= ~(1<<(2+currentStack));
    }

    // increment counters
    bitIndex >>= 1;
    // if bit index is at zero, then it's time for a new byte
    if (bitIndex == 0) {
      if (byteIndex < 5) {
        bitIndex = (1<<7);
        byteIndex++;
      }
      // if we get here we've done all the bytes in a card
      else {
        cardCount++;
        // more cards to program
        if (cardCount < currentStackSize) {
          wait = true;
          waitCount = 0;
          currentStackData += 6;
        }
        // no more cards to program
        else {
          stopTimer();
        }
      }
    }
  }
  else if (currentStackSize == 0) {
    stopTimer();
  }
  // stop waiting if it's been long enough
  else if (++waitCount > LED_WAIT_COUNT) {
   wait = false;
   byteIndex = 0;
   bitIndex = (1<<7);
  }
}
