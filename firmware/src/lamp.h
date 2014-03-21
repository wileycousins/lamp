// reflow
// Copyright 2014 by Wiley Cousins, LLC.
// shared under the terms of the MIT License
//
// file: lamp.h
// description: header file for the lamp application

#ifndef LAMP_H
#define LAMP_H

// only inlcudes necessary for the header to work
#include <stdint.h>

// global objects
// gonna be using one LED card on stack 0 today
// package = 48 bits = 6 bytes
uint8_t ledData[6];
volatile uint8_t bitCount;
volatile uint8_t byteIndex;
volatile uint8_t bitIndex;

// led stack stuff
// array of values tranlating ADC readings to stack size
// cap it at 20 cards because that seems reasonable
// calculated with 8-bit ADC, 10k sense resistor on hub, 1k sense resitor on cards
// relation: N = (2560/(256-ADC))-10
#define MAX_STACK_SIZE 20
uint8_t adcToStackSize[MAX_STACK_SIZE+1] = {
  0, 23, 42, 59, 73, 85, 96, 105, 113, 121, 128, 134, 139, 144, 149, 153, 157, 161, 164
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
// sense led car stack size
void senseStacks(uint8_t *size);

#endif