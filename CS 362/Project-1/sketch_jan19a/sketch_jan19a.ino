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
