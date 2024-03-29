/* jsee4Lab2.ino */
/* -----------------------------------------------------------------------------------
 >> Assignment details and provided code are created and owned by Patrick Troy.
 >> University of Illinois Chicago - CS 362, Spring 2024
 >> -----------------------------------------------------------------------------------
 >> Course : Computer Design
 >> Author : John Ezra See (668942698, jsee4)
 >> System : Windows 11 w/ Arduino IDE
 >> References: https://docs.arduino.cc/ 
                https://www.ladyada.net/learn/arduino/lesson5.html
 - -                             - -
 >> Project/Lab Name    : Lab 2: Three Bit Counter
 >> Brief Description   : The arduino consists of three leds which represent each 
                          single bit. Two buttons used to increment/decrement a 1-7
                          value represented by the state of the LED.
 >> Assumptions         : None
 >> Date demonstrated   : 1/29/2024
 >> Teaching Assistant  : Jonathon
------------------------------------------------------------------------------------- */
// Global variables:
// Constants/Pins:
const int incrementPin = 1; // Input
const int decrementPin = 2; // Input
const int firstBit = 13;    // Output
const int secondBit = 12;   // Output
const int thirdBit = 11;    // Output

// Changing variables:
int incrementState = 0;  // variable for reading the pushbutton status
int value = 1; // Start with the value 1.
int decrementState = 0;
int prevDecrementState = 0;
int prevIncrementState = 0; 

// Debounce variables:
unsigned long lastDebounceTime = 0;
unsigned long debounceDelay = 10;

void setup() {
  pinMode(firstBit, OUTPUT);
  pinMode(secondBit, OUTPUT);
  pinMode(thirdBit, OUTPUT);
  pinMode(incrementPin, INPUT);
  pinMode(decrementPin, INPUT);
}

void loop() {
  // if (millis() - lastDebounceTime <= debounceDelay) return; // Within the delay, don't 
  //                                                           // do anything...
  incrementState = digitalRead(incrementPin);
  decrementState = digitalRead(decrementPin);

  // How long should the button be held minimum for it to be considered valid?
  delay(10);

  int incrementState2 = digitalRead(incrementPin);
  int decrementState2 = digitalRead(decrementPin);

  // Check for consistent readings using the Brookly Debounce method.
  if ((incrementState != incrementState2) || (decrementState != decrementState2)) return; 

  bool incrementPressed = incrementState == HIGH && prevIncrementState != HIGH;
  bool decrementPressed = decrementState == HIGH && prevDecrementState != HIGH;

  if (incrementPressed && value < 7) value++;
  if (decrementPressed && value > 0) value--;
  // if (incrementPressed || decrementPressed) lastDebounceTime = millis(); // Reset 
  //                                             // debounce time when button is pressed.

  digitalWrite(firstBit, (value & 0x1) >= 1);
  digitalWrite(secondBit, (value & 0x2) >= 1);
  digitalWrite(thirdBit, (value & 0x4) >= 1);
  
  prevIncrementState = incrementState;
  prevDecrementState = decrementState;
}
