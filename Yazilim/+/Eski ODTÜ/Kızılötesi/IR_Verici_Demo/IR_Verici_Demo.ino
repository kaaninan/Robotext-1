#include <IRremote.h>

// Uno Pin:  3
// Mega Pin: 9

IRsend irsend;

void setup(){}

void loop() {
  irsend.sendNEC(0xFFA25D, 32);
  irsend.sendNEC(0xFFA25D, 32);
  irsend.sendNEC(0xFFA25D, 32);
  delay(2000);
  irsend.sendNEC(0xFF629D, 32);
  irsend.sendNEC(0xFF629D, 32);
  irsend.sendNEC(0xFF629D, 32);
  delay(2000);
}
