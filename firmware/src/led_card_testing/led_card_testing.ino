#include <avr/interrupt.h>

#define LED_WAIT_COUNT  4

// led stacks
#define NUM_STACKS  3
#define MAX_STACK_SIZE 10
uint8_t adcToStackSize[MAX_STACK_SIZE+1] = {
  0, 232, 213, 196, 182, 170, 160, 150, 142, 134, 128
};

// global objects
uint8_t *currentStackData;
uint8_t currentStackSize;
volatile uint8_t cardCount;
volatile uint8_t byteIndex;
volatile uint8_t bitIndex;
volatile bool wait;
volatile uint8_t waitCount;

void setup() {
  Serial.begin(115200);
  
  Serial.println("strt");
  
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

  // print stack sizes
  //Serial.print("Stack 0 size: "); Serial.println(stackSize[0]);
  //Serial.print("Stack 1 size: "); Serial.println(stackSize[1]);
  //Serial.print("Stack 2 size: "); Serial.println(stackSize[2]);
  

  if (stackSize[0] >= 1) {
    set(500, 0, 0, 0, stack[0]);
  }
  if (stackSize[0] >= 2) {
    set(0, 500, 0, 1, stack[0]);
  }
  if (stackSize[0] >= 3) {
    set(0, 0, 500, 2, stack[0]);
  }

  if (stackSize[0]) {
    // for testing, set ledData to stack0 data
    currentStackData = stack[0];
    currentStackSize = stackSize[0];
    startTimer();
  }

  // print stack data
  //Serial.print("current stack data: ");
  //for (uint8_t i=0; i<6*currentStackSize; i++) {
    //Serial.print(currentStackData[i]); Serial.print(" ");
  //}
  //Serial.println();
}

void loop() {

  
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
  // read the data for the cpu
  uint8_t read = ADCH;
  
  // read the stack sizes
  for (uint8_t i=0; i<NUM_STACKS; i++) {
    
    // set ADC input to correct input
    ADMUX = ((ADMUX & ~0xF) | (2+i));
    // take the reading
    ADCSRA |= (1<<ADSC);
    while (ADCSRA & (1<<ADSC));
    uint8_t read = ADCH;
    
    // ARDUINO
    //uint8_t read = (uint8_t)(analogRead(2+i) >> 2);
    //Serial.print("reading for stack ");
    //Serial.print(i); 
    //Serial.print(" is ");
    //Serial.println(read);
    // END ARDUINO
    
    // translate it into stack size
    // relation is N = (2560/(256-ADC))-10
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

void initTimer(void) {
  // use 8 bit timer 0
  // looking for f = 230.4 kHz
  // set to CTC mode with prescaler at 64 and top at 1 
  TCCR0A = (1<<WGM01);
  TCCR0B = ( (1<CS02) | (1<<CS00) );
  OCR0A = 255;
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

// led serial ISR
ISR(TIMER0_COMPA_vect) {
  if (!wait) {
    // 1 wire serial
    // pulse the data line once to signal data
    //PORTD |= (1<<2);
    //PORTD &= ~(1<<2);

    // if data is a one, pulse again to signal a 1
    // no pulse is a 0
    if (currentStackData[byteIndex] & bitIndex) {
      //PORTD |= (1<<2);
      //PORTD &= ~(1<<2);
      //Serial.print('1');
    }
    else {
      //Serial.print('0');
    }

    // increment the counters
    if (byteIndex < 6 || bitIndex > 1) {
      if (bitIndex > 1) {
        bitIndex >>= 1;
      }
      else {
        bitIndex = (1<<7);
        byteIndex++;
      }
    }
    else {
      Serial.println();
      Serial.print("ct"); Serial.println(cardCount);
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
        Serial.println("dt");
      }
    }
  }
  else if (++waitCount > LED_WAIT_COUNT) {
    Serial.println("wd");
    wait = false;
  }
}

