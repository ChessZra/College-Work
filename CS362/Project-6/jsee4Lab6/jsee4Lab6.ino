/* jsee4Lab6.ino */
/* -----------------------------------------------------------------------------------
 >> Assignment details and provided code are created and owned by Patrick Troy.
 >> University of Illinois Chicago - CS 362, Spring 2024
 >> -----------------------------------------------------------------------------------
 >> Course : Computer Design
 >> Author : ChessZra (668942698, jsee4)
 >> System : Windows 11 w/ Arduino IDE
 >> References: https://docs.arduino.cc/ 
 >>             https://www.arduino.cc/en/Tutorial/LiquidCrystalScroll
 >>             https://playground.arduino.cc/Code/Time/
 >>             https://www.arduino.cc/reference/en/libraries/liquidcrystal/
 >>             https://www.arduino.cc/reference/en/language/functions/communication/serial/readbytesuntil/
 >>             https://www.mathsisfun.com/leap-years.html 
 - -                             - -
 >> Project/Lab Name    : Lab 6: Computer I/O with an LCD
 >> Brief Description   : This arduino works with the LCD and the computer I/O
 >>                       system. The arduino is able to read in time and date inputs
 >>                       and displays it into the LCD.
 >> Assumptions         : None
 >> Date demonstrated   : 02/26/2024
 >> Teaching Assistant  : Jon
------------------------------------------------------------------------------------- */
// include the library code:
#include <LiquidCrystal.h>
#include <TimeLib.h>

// Global variables:
const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

int BUFFER_SIZE = 256;
char buffer[256];
bool dateTaken = false;
int mon = 6, d = 30, yr = 2003, hr = 0, min = 0, sec = 0;

void setup() {
  lcd.begin(16, 2);
  Serial.begin(9600);
  Serial.println("\nPlease enter a date(mm/dd/yyyy)");
  setTime(0, 0, 0, 30, 6, 2003);
}

// This function pads the buffer array with null terminated chars.
void clearBuffer(char buffer[]) {
  for (int i = 0; i < BUFFER_SIZE; i++) buffer[i] = '\0';
}

// This function displays the time in the LCD screen.
void displayTime() {
  lcd.setCursor(0, 0);
  if (month() < 10) lcd.print(0);
  lcd.print(month());
  lcd.print('/');
  if (day() < 10) lcd.print(0);
  lcd.print(day());
  lcd.print('/');
  if (year() < 10) lcd.print(0);
  lcd.print(year());

  lcd.setCursor(0, 1);
  if (hour() < 10) lcd.print(0);
  lcd.print(hour());
  lcd.print(':');
  if (minute() < 10) lcd.print(0);
  lcd.print(minute());
  lcd.print(':');
  if (second() < 10) lcd.print(0);
  lcd.print(second());
}

// This function checks whether the given year is a leap year.
bool isLeapYear(int year) {
  return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

// This function returns true if buffer satisfies (mm/dd/yyyy)
// If there are no errors found, assigns mon, d, yr accordingly.
bool parseDate() {
  if (strlen(buffer) != 10) return false;

  // Extract month, day, and year substrings
  char monthStr[3];
  char dayStr[3];
  char yearStr[5];
  strncpy(monthStr, buffer, 2);
  monthStr[2] = '\0';
  strncpy(dayStr, buffer + 3, 2);
  dayStr[2] = '\0';
  strncpy(yearStr, buffer + 6, 4);
  yearStr[4] = '\0';

  // Convert substrings to integers
  mon = atoi(monthStr);
  d = atoi(dayStr);
  yr = atoi(yearStr);

  // Validate month, day, and year
  if (mon < 1 || mon > 12 || d < 1 || d > 31 || yr < 1000 || yr > 9999)
    return false;
  // Validate day according to the month
  if ((mon == 4 || mon == 6 || mon == 9 || mon == 11) && d > 30)
    return false;
  if (mon == 2 && isLeapYear(yr) && d > 29) // Leap year
    return false;
  if (mon == 2 && !isLeapYear(yr) && d > 28) // Non-leap year
    return false;

  // Then the date is valid:
  return true;
}

// This function returns true if buffer satisfies (hh:mm:ss)
// If there are no errors found, assigns hr, min, sec accordingly.
bool parseTime() {
  if (strlen(buffer) != 8)
    return false;

  // Extract hour, minute, and second substrings:
  char hourStr[3];
  char minStr[3];
  char secStr[3];
  strncpy(hourStr, buffer, 2);
  hourStr[2] = '\0';
  strncpy(minStr, buffer + 3, 2);
  minStr[2] = '\0';
  strncpy(secStr, buffer + 6, 2);
  secStr[2] = '\0';

  // Convert substrings to integers:
  hr = atoi(hourStr);
  min = atoi(minStr);
  sec = atoi(secStr);

  // Validate hour, minute, and second:
  if (hr < 0 || hr > 23 || min < 0 || min > 59 || sec < 0 || sec > 59)
    return false;

  // Then the time is valid:
  return true;
}

// Inputs that you should be testing:
// • valid dates and times
// • invalid dates and times
// • times right before the end of a day/month (4/30/24 @ 23:59:45) to show change of
// day/month
// • times right before the end of a year (12/31/23 @ 23:59:45) to show change of day/year
// • times right before leap day (2/28/24 @ 23:59:45) to show inclusion of leap day 

void loop() {
  // Get input from the computer:
  if (Serial.available() > 0) {
    clearBuffer(buffer);
    Serial.readBytesUntil(10, buffer, 256);
    if (!dateTaken) { // DATE INPUT:
      if (!parseDate()) {
        Serial.println("Invalid date...");
        Serial.println("Please enter a date(mm/dd/yyyy)");
        return;
      }
      Serial.println("Please enter a time(hh:mm:ss)");
      dateTaken = true;
    } else {  // TIME INPUT:
      if (!parseTime()) {
        Serial.println("Invalid time...");
        Serial.println("Please enter a time(hh:mm:ss)");
        return;
      }
      setTime(hr, min, sec, d, mon, yr);
      dateTaken = false;
      Serial.println("VALID date and time input!!\n");
      Serial.println("Please enter a date(mm/dd/yyyy)");
    }
  }
  displayTime();
}