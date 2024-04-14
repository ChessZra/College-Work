/* jsee4Lab9.ino */
/* -----------------------------------------------------------------------------------
 >> Assignment details and provided code are created and owned by Patrick Troy.
 >> University of Illinois Chicago - CS 362, Spring 2024
 >> -----------------------------------------------------------------------------------
 >> Course : Computer Design
 >> Author : John Ezra See (668942698, jsee4)
 >> System : Windows 11 w/ Arduino IDE
 >> References: https://docs.arduino.cc/ 
 >>             https://www.arduino.cc/en/Tutorial/LiquidCrystalScroll
 >>             https://www.arduino.cc/en/Tutorial/LibraryExamples/HelloWorld
 >>             https://www.arduino.cc/reference/en/libraries/liquidcrystal/
 - -                             - -
 >> Project/Lab Name    : Lab 9 - RGB LED
 >> Brief Description   : This program uses the RGB LED and separate R-G-B LEDS!
 >> Assumptions         : None
 >> Date demonstrated   : 03/27/24
 >> Teaching Assistant  : Jon
------------------------------------------------------------------------------------- */

// Global variables ::
// For the joystick:
const int joyXPin = A0;
const int joyYPin = A1;
const int potPin = A2;

// For the RGB led:
const int redPin = 3;
const int greenPin = 5;
const int bluePin = 6;

// For the single-color-LEDS:
const int singleRedPin = 9;
const int singleGreenPin = 10;
const int singleBluePin = 11;

unsigned long curTime, previousMillis = 0;

void setup() {
  // Serial.begin(9600); // For debugging purposes...
  pinMode(joyXPin, INPUT);
  pinMode(joyYPin, INPUT);
  pinMode(potPin, INPUT);

  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);

  pinMode(singleRedPin, OUTPUT);
  pinMode(singleGreenPin, OUTPUT);
  pinMode(singleBluePin, OUTPUT);
}

void lightAllLED(int r, int g, int b) {
  analogWrite(singleRedPin, r);
  analogWrite(singleGreenPin, g);
  analogWrite(singleBluePin, b);

  analogWrite(redPin, r);
  analogWrite(greenPin, g);
  analogWrite(bluePin, b);
}

void loop() {
  curTime = millis();
  if (curTime - previousMillis < 15) return;
  previousMillis = curTime;

  int joyXValue = analogRead(joyXPin);
  int joyYValue = analogRead(joyYPin);
  int potValue = analogRead(potPin);

  // A convenient fix for the fluctuations between the values 0-20.
  joyXValue = (joyXValue < 20) ? 0 : joyXValue;
  joyYValue = (joyYValue < 20) ? 0 : joyYValue;
  potValue = (potValue < 20) ? 0 : potValue;

  // Serial.print(joyXValue);
  // Serial.print(" ");
  // Serial.print(joyYValue);
  // Serial.print(" ");
  // Serial.println(potValue);
  int r = map(joyXValue, 0, 1023, 0, 255);
  int g = map(joyYValue, 0, 1023, 0, 255);
  int b = map(potValue, 0, 1023, 0, 255);

  lightAllLED(r, g, b);
}