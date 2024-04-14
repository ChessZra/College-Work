/* jsee4Lab8.ino */
/* -----------------------------------------------------------------------------------
 >> Assignment details and provided code are created and owned by Patrick Troy.
 >> University of Illinois Chicago - CS 362, Spring 2024
 >> -----------------------------------------------------------------------------------
 >> Course : Computer Design
 >> Author : ChessZra (668942698, jsee4)
 >> System : Windows 11 w/ Arduino IDE
 >> References: https://docs.arduino.cc/ 
 >>             https://www.arduino.cc/en/Tutorial/LiquidCrystalScroll
 >>             https://www.arduino.cc/en/Tutorial/LibraryExamples/HelloWorld
 >>             https://www.arduino.cc/reference/en/libraries/liquidcrystal/
 >>             https://www.arduino.cc/reference/en/language/functions/external-interrupts/attachinterrupt/
 - -                             - -
 >> Project/Lab Name    : Lab 8 - Interrupt Service Routines (ISR)
 >> Brief Description   : This program demonstrates the ISR functionality on the arduino 
 >>                       board by utilizing a few bush buttons and a single 16x2 LCD 
 >>                       screen.
 >> Assumptions         : None
 >> Date demonstrated   : 03/25/2024
 >> Teaching Assistant  : Amir
------------------------------------------------------------------------------------- */
// Preprocessor Directives ::
#include <LiquidCrystal.h>

// Global Variables ::
const int rs = 12, en = 11, d4 = 7, d5 = 6, d6 = 5, d7 = 4;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

// Constants/Pins:
const int button1 = 2; // Interrupt button
const int button2 = 3; // Continue button

// Changing variables:
int currentState = 0;
unsigned long previousMillis = 0;

// LCD variables:
char interruptMessage[] = { 
"Interrupt received! "
};
int n = strlen(interruptMessage), low = 0;
char window[16];

char interruptMessage2[] = {
"Press button2 to continue. "
};
int n2 = strlen(interruptMessage2), low2 = 0;
char window2[16];

void setup() {
  lcd.begin(16, 2);
  pinMode(button1, INPUT);
  pinMode(button2, INPUT);

  // Interrupt pins:
  pinMode(button1, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(button1), button1Pressed, RISING);
  pinMode(button2, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(button2), button2Pressed, RISING);
}

void button1Pressed() {
  low = 0;  // Just to reset the scrolling message to the beginning...
  low2 = 0; // Just to reset the scrolling message to the beginning...
  currentState = 1;
}

void button2Pressed() {
  if (currentState == 1) {
    previousMillis = millis();
    currentState = 0;
  }
}

void State0() {
  lcd.setCursor(0, 0);
  lcd.print("System on for:             ");
  lcd.setCursor(0, 1);
  int timeNow = (millis() - previousMillis) / 1000;
  char timeMessage[16];
  sprintf(timeMessage, "%d                  ", timeNow);
  lcd.print(timeMessage);
}

void State1() {
  if (low == n) low = 0; // Back to the beginning of the first message.
  if (low2 == n2) low2 = 0; // Back to the beginning of the second message.

  for (int i = low, j = 0; i < (low + 16); i++, j++) window[j] = interruptMessage[i % n];
  for (int i = low2, j = 0; i < (low2 + 16); i++, j++) window2[j] = interruptMessage2[i % n2];


  lcd.setCursor(0, 0);
  lcd.print(window);
  lcd.setCursor(0, 1);
  lcd.print(window2);

  low++;
  low2++;

  delay(300);
}

void loop() { 
  if (currentState == 0) {
    State0();
  } else if (currentState == 1) {
    State1();
  }
}