// led stacks
#define NUM_STACKS  3
#define MAX_STACK_SIZE 10
uint8_t adcToStackSize[MAX_STACK_SIZE+1] = {
  0, 232, 213, 196, 182, 170, 160, 150, 142, 134, 128
};

void setup() {
  Serial.begin(9600);
  
  Serial.println("beginning test");
  
  // find out how many led cards are in each stack, and create data arrays for each
  uint8_t *stack[NUM_STACKS];
  uint8_t stackSize[NUM_STACKS];
  senseStacks(stackSize);
  for (uint8_t i=0; i<NUM_STACKS; i++) {
    if (stackSize[i] > 0) {
      stack[i] = initDataArray(stackSize[i]);
    }
  }

  // print stack sizes
  Serial.print("Stack 0 size: "); Serial.println(stackSize[0]);
  Serial.print("Stack 1 size: "); Serial.println(stackSize[1]);
  Serial.print("Stack 2 size: "); Serial.println(stackSize[2]);
  
  // start with just a little red
  uint16_t red = 4000;
  uint16_t grn = 0x0;
  uint16_t blu = 0x0;

  // set that color and send the data
  set(red, grn, blu, 0, stack[0]);
  
  // print stack data
  Serial.print("stack 0 data: ");
  for (uint8_t i=0; i<6*stackSize[0]; i++) {
    Serial.print(stack[0][i]); Serial.print(" ");
  }
  Serial.println();
  Serial.print("stack 1 data: ");
  for (uint8_t i=0; i<6*stackSize[1]; i++) {
    Serial.print(stack[1][i]); Serial.print(" ");
  }
  Serial.println();
    Serial.print("stack 2 data: ");
  for (uint8_t i=0; i<6*stackSize[2]; i++) {
    Serial.print(stack[2][i]); Serial.print(" ");
  }
  Serial.println();
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
    Serial.print("reading for stack ");
    Serial.print(i); 
    Serial.print(" is ");
    Serial.println(read);
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
