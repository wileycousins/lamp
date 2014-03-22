// reflow
// Copyright 2014 by Wiley Cousins, LLC.
// shared under the terms of the MIT License
//
// file: lamp.h
// description: header file for the lamp application

#ifndef LAMP_H
#define LAMP_H

#define LED_WAIT_COUNT  4

// only inlcudes necessary for the header to work
#include <stdint.h>

// global objects
uint8_t *currentStackData;
uint8_t currentStackSize;
volatile uint8_t cardCount;
volatile uint8_t byteIndex;
volatile uint8_t bitIndex;
volatile bool wait;
volatile uint8_t waitCount;

// led stack stuff
// array of values tranlating ADC readings to stack size
// cap it at 20 cards because that seems reasonable
// calculated with 8-bit ADC, 10k sense resistor on hub, 1k sense resitor on cards
// relation: ADC = (ADCmax+1)(1-(N/(10+N)))
#define MAX_STACK_SIZE 10
uint8_t adcToStackSize[MAX_STACK_SIZE+1] = {
  0, 232, 213, 196, 182, 170, 160, 150, 142, 134, 128
};

// function prototypes
int main(void);
// take care of unused pins
void initUnusedPins(void);
// initialize a timer ISR for serial data
void initTimer(void);
// send data to the led stacks
void startTimer(void);
void stopTimer(void);
// set led color
void set(uint16_t red, uint16_t grn, uint16_t blu, uint8_t *data);
// set led color of a certain led in a certain stack
void set(uint16_t red, uint16_t grn, uint16_t blu, uint8_t led, uint8_t *data);
// sense led car stack size
void senseStacks(uint8_t *size);
// allocate and initialize to 0 an array for led data depnding on stack size
uint8_t *initDataArray(uint8_t n);

#endif