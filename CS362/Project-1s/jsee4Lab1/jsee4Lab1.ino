/* jsee4Lab1.ino */
/* -----------------------------------------------------------------------------------
 >> Assignment details and provided code are created and owned by Patrick Troy.
 >> University of Illinois Chicago - CS 362, Spring 2024
 >> -----------------------------------------------------------------------------------
 >> Course : Computer Design
 >> Author : John Ezra See (668942698, jsee4)
 >> System : Windows 11 w/ Arduino IDE
 >> References: https://docs.arduino.cc/
 - -                             - -
 >> Project/Lab Name    : Lab 1: 3 way blink
 >> Brief Description   : This code allows three LED's to alternate between a given
                          interval.
 >> Assumptions         : None
 >> Date demonstrated   :
 >> Teaching Assistant  :
------------------------------------------------------------------------------------- */
// Global variables:
int pinOnBoard = LED_BUILTIN; // Green LED
int pinRed = 12; // Red LED
int pinGreen = 11; // Green LED;

unsigned long previousMillis = 0; // Variable to store previous time
const long interval = 500; // Interval at which to blink.

int onBoardState = HIGH;
int redState = LOW;
int greenState = LOW;

void setup() {
  pinMode(pinRed, OUTPUT);
  pinMode(pinOnBoard, OUTPUT);
  pinMode(pinGreen, OUTPUT);
}

void loop() {
  unsigned long currentMillis = millis();
    
  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;

    if (onBoardState == HIGH) { // Turn Red on:
      redState = HIGH;
      onBoardState = LOW;
      greenState = LOW;
    } else if (redState == HIGH) { // Turn Green on:
      redState = LOW;
      onBoardState = LOW;
      greenState = HIGH;
    } else if (greenState == HIGH) { // Turn onBoard on:
      redState = LOW;
      onBoardState = HIGH;
      greenState = LOW; 
    }

    digitalWrite(pinOnBoard, onBoardState);
    digitalWrite(pinRed, redState);
    digitalWrite(pinGreen, greenState);
  } 
}
