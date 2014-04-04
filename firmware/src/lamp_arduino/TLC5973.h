// lamp
// Copyright 2014 by Wiley Cousins, LLC.
// shared under the terms of the MIT License
//
// file: TLC5973.h
// description: header file for the TLC5973 led driver class

#ifndef LAMP_TLC5973_H
#define LAMP_TLC5973_H

#include <stdint.h>

#ifndef TLC5973_PORT
#define TLC5973_PORT  PORTD
#endif
// DDR from port register macros
#ifndef DDR
#define DDR(port) (*(&port-1))
#endif


class TLC5973 {
public:
  // contructor allocates data array
  // takes in pin number
  TLC5973(uint8_t pin, uint8_t n);

  
private:

};

#endif