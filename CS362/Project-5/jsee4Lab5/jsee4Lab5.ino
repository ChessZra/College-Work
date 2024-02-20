/* jsee4Lab5.ino */
/* -----------------------------------------------------------------------------------
 >> Assignment details and provided code are created and owned by Patrick Troy.
 >> University of Illinois Chicago - CS 362, Spring 2024
 >> -----------------------------------------------------------------------------------
 >> Course : Computer Design
 >> Author : ChessZra (668942698, jsee4)
 >> System : Windows 11 w/ Arduino IDE
 >> References: https://docs.arduino.cc/ 
 >>             https://www.circuitbasics.com/how-to-use-photoresistors-to-detect-light-on-an-arduino/
 >>             https://www.youtube.com/watch?v=gj-H_agfd6U
 - -                             - -
 >> Project/Lab Name    : Lab 5: Multiple Inputs and Outputs
 >> Brief Description   : The arduino consists of a photoresistor that is indicated
 >>                       by the number of LEDS that are turned on. As well as
 >>                       a potentiometer that controls the pitch and timing of the buzzer.
 >> Assumptions         : None
 >> Date demonstrated   : 02/19/2024
 >> Teaching Assistant  : Jon
------------------------------------------------------------------------------------- */
// Global Variables:
int ledPin1 = 8, ledPin2 = 9, ledPin3 = 10, ledPin4 = 11;
int photoPin = A0, light;
unsigned long previousMillis = 0; // Variable to store previous time
const long interval = 50;
int l1State, l2State, l3State, l4State;

int potPin = A1, potVal, prevPotState = -1, curPotState;
int buzzerPin = 7;
int soundDelay[] = {-1, 9000, 5000, 3000, 2000, 1500, 0}; // -1 indicates no sound
int soundPitch[] = {-1, 523, 587, 659, 698, 784, 880}; // C4, D4, E4, F4, G4, A4
unsigned long lastSounded;

void setup() {
  pinMode(ledPin1, OUTPUT);
  pinMode(ledPin2, OUTPUT);
  pinMode(ledPin3, OUTPUT);
  pinMode(ledPin4, OUTPUT);
  tone(buzzerPin, 1000, 2000);
  Serial.begin(9600);
}

void loop() {
  unsigned long currentMillis = millis();

  if (currentMillis - previousMillis >= interval) {
    light = analogRead(photoPin);
    if (light <= 350) {
      l1State = HIGH; l2State = HIGH; l3State = HIGH; l4State = HIGH; // 4 lights
    } else if (light <= 500) {
      l1State = HIGH; l2State = HIGH; l3State = HIGH; l4State = LOW; // 3 lights
    } else if (light <= 700) {
      l1State = HIGH; l2State = HIGH; l3State = LOW; l4State = LOW; // 2 lights
    } else if (light <= 900) {
      l1State = HIGH; l2State = LOW; l3State = LOW; l4State = LOW; // 1 light
    } else { 
      l1State = LOW; l2State = LOW; l3State = LOW; l4State = LOW; // 0 light
    }
    digitalWrite(ledPin1, l1State);
    digitalWrite(ledPin2, l2State);
    digitalWrite(ledPin3, l3State);
    digitalWrite(ledPin4, l4State);
    previousMillis = currentMillis;
  }
  potVal = analogRead(potPin);
  // curPotState ranges from 0, 1, 2, 3, 4, 5, 6
  curPotState = potVal / 169; // 1023 / 6 = 170.5, we'll use 169. 

  if (prevPotState != curPotState) {
    prevPotState = curPotState;
    lastSounded = -1;
  }

  if (currentMillis - lastSounded >= soundDelay[curPotState] && curPotState != 0) {
    tone(buzzerPin, soundPitch[curPotState], 1000);
    lastSounded = currentMillis;
  }
}