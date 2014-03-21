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
  //uint8_t *stack[NUM_STACKS];
  uint8_t stackSize[NUM_STACKS];
  senseStacks(stackSize);

  //stackSize[0] = (uint8_t)(analogRead(2) >> 2);
  //stackSize[1] = (uint8_t)(analogRead(3) >> 2);
  //stackSize[2] = (uint8_t)(analogRead(4) >> 2);

  // print stack sizes
  Serial.println(stackSize[0]);
  Serial.println(stackSize[1]);
  Serial.println(stackSize[2]);
}

void loop() {

  
}


// initialize analog inputs and sense stack sizes
void senseStacks(uint8_t *size) {
  /*
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
  */
  
  // read the stack sizes
  for (uint8_t i=0; i<NUM_STACKS; i++) {
    // set ADC input to correct input
    //ADMUX = ((ADMUX & ~0xF) | (2+i));
    // take the reading
    //ADCSRA |= (1<<ADEN);
    //while (ADCSRA & (1<<ADSC));
    //uint8_t read = ADCH;
    
    // ARDUINO
    uint8_t read = (uint8_t)(analogRead(2+i) >> 2);
    Serial.print("reading for stack ");
    Serial.print(i); 
    Serial.print(" is ");
    Serial.println(read);
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
