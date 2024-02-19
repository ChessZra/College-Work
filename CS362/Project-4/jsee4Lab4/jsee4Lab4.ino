/* jsee4Lab4.ino */
/* -----------------------------------------------------------------------------------
 >> Assignment details and provided code are created and owned by Patrick Troy.
 >> University of Illinois Chicago - CS 362, Spring 2024
 >> -----------------------------------------------------------------------------------
 >> Course : Computer Design
 >> Author : ChessZra (668942698, jsee4)
 >> System : Windows 11 w/ Arduino IDE
 >> References: https://docs.arduino.cc/ 
 >>             https://www.circuitbasics.com/how-to-use-photoresistors-to-detect-light-on-an-arduino/
 - -                             - -
 >> Project/Lab Name    : Lab 4: Analog Input - Photoresistor
 >> Brief Description   : The arduino consists of a 16x2 LCD and a photoresistor. 
 >>                       it will display the time and different levels of brightness.
 >> Assumptions         : None
 >> Date demonstrated   : 02/12/2024
 >> Teaching Assistant  : Amir
------------------------------------------------------------------------------------- */
// Preprocessor Directives:
#include <LiquidCrystal.h>

// Global variables:
const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);
int photoPin = A0, light;

unsigned long previousMillis = 0; // Variable to store previous time
const long interval = 50;

void setup() {
  lcd.begin(16, 2);
  Serial.begin(9600);
}

void loop() {
  unsigned long currentMillis = millis();

  if (currentMillis - previousMillis >= interval) {
    // When no light, resistance increases, voltage is low. 
    // When light, resistance decreases, voltage is high.
    light = analogRead(photoPin);
    // dark, partially dark, medium, fully lit, brightly lit 
    lcd.setCursor(0, 0);

    if (light <= 45) {
      lcd.print("dark                     ");
    } else if (light <= 60) {
      lcd.print("partially dark           ");
    } else if (light <= 75) {
      lcd.print("medium                   ");
    } else if (light <= 115) {
      lcd.print("fully lit                ");
    } else {
      lcd.print("brightly lit             ");
    }

    previousMillis = currentMillis;
  }
    // Display the time:
    lcd.setCursor(0, 1);
    lcd.print(millis() / 1000);
}