/* jsee4Lab3.ino */
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
 - -                             - -
 >> Project/Lab Name    : Lab 3: Liquid Crystal Display – LCD
 >> Brief Description   : The arduino consists of a 16x2 LCD. The first line will 
 >>                       scroll through the quote. The second line is just my name.
 >> Assumptions         : None
 >> Date demonstrated   : 
 >> Teaching Assistant  : 
------------------------------------------------------------------------------------- */
// include the library code:
#include <LiquidCrystal.h>

// Global variables:
const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);
char quote[] = {
"    My unmatched perspicacity coupled with my sheer indefatigability \ 
makes me a feared opponent in any realm of human endeavour.     "
};

int n = strlen(quote), low = 0;
char name[16], window[16];

void setup() {
  lcd.begin(16, 2);
  sprintf(name, "      %s", "John");
  lcd.setCursor(0, 1);
  lcd.print(name);
}

void loop() {
  if (low == n) low = 0; // Back to the beginning of the quote.

  for (int i = low, j = 0; i < (low + 16); i++, j++) window[j] = quote[i % n];

  lcd.setCursor(0, 0);
  lcd.print(window);

  low += 1;
  delay(250);
}