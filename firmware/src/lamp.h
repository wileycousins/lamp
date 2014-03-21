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

// function prototypes
int main(void);
// initialize a timer ISR for serial data
void initTimer(void);
// send data to the led stacks
void startTimer(void);
void stopTimer(void);
// set led color
void set(uint16_t red, uint16_t grn, uint16_t blu, uint8_t *data);

#endif