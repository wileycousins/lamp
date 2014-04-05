// avr includes
#include <stdlib.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

// application includes
#include "matrix.h"
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

  // create properly sized data arrays for the LED drivers
  uint8_t *stackData[NUM_STACKS];
  uint8_t stackSize[NUM_STACKS];
  senseStacks(stackSize);
  for (uint8_t i=0; i<NUM_STACKS; i++) {
    if (stackSize[i] > 0) {
      stackData[i] = initDataArray(stackSize[i]);
    }
  }
  // intialize the led data timer and start at stack 0
  initTimer();
  currentStack = 0;
  currentStackData = stackData[0];
  currentStackSize = stackSize[0];
  // array to hold card colors before transfering to driver data arrays
  uint16_t rgb[3];


  // get the effects stuff ready
  // set all LEDs to white by default
  uint8_t def[3] = {255, 255, 255};
  // allocate the LED matrix
  Matrix leds(stackSize);
  // create an effects object
  Effects fx(&leds, def, 2);


  // tell it to go green for about a second
  //uint8_t holdParams[3] = {0, 255, 0};
  //fx.setEffect(EFFECT_HOLD, holdParams, 5);

  // tell it to do a quick swirl
  uint8_t swirlParams[3] = {255, 255, 255};
  fx.setEffect(EFFECT_SWIRL, swirlParams, 20);


  for (uint8_t s=0; s<MATRIX_NUM_STACKS; s++) {
    for (uint8_t c=0; c<stackSize[s]; c++) {
      leds.get(s, c, rgb);
      set(rgb[0], rgb[1], rgb[2], c, stackData[s]);
    }
  }

  // don't stop believing
  uint8_t loopCounter = 0;
  for (;;) {
    // if timer is not currently going, send data to next stack
    if (!TIMSK0) {
      currentStack = (currentStack < 2) ? (currentStack+1) : 0;
      currentStackData = stackData[currentStack];
      currentStackSize = stackSize[currentStack];
      startTimer();
    }

    // every three loops, recalculate the color
    if (++loopCounter > 3) {
      // BLINK THAT LED LIKE IT'S YOUR JOB
      beatHeart();

      // refresh the effect
      loopCounter = 0;
      fx.refresh();
      
      // send the matrix data to the LED drivers
      for (uint8_t s=0; s<MATRIX_NUM_STACKS; s++) {
        for (uint8_t c=0; c<stackSize[s]; c++) {
          leds.get(s, c, rgb);
          set(rgb[0], rgb[1], rgb[2], c, stackData[s]);
        }
      }
    }

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

void beatHeart(void) {
  PINB |= (1<<1);
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
