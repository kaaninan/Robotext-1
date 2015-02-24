/*
 * IRremote: IRsendDemo - demonstrates sending IR codes with IRsend
 * An IR LED must be connected to Arduino PWM pin 3.
 * Version 0.1 July, 2009
 * Copyright 2009 Ken Shirriff
 * http://arcfn.com
 */

#include <IRremote.h>

IRsend irsend;

void setup()
{
  Serial.begin(9600);
}

void loop() {
      irsend.sendNEC(0xFFA25D, 32);
      irsend.sendNEC(0xFFA25D, 32);
      irsend.sendNEC(0xFFA25D, 32);
      irsend.sendNEC(0xFFA25D, 32);
      irsend.sendNEC(0xFFA25D, 32);
      delay(2000);
      irsend.sendNEC(0xFF629D, 32);
      irsend.sendNEC(0xFF629D, 32);
      irsend.sendNEC(0xFF629D, 32);
      irsend.sendNEC(0xFF629D, 32);
      irsend.sendNEC(0xFF629D, 32);
      irsend.sendNEC(0xFF629D, 32);

      delay(2000);


}
