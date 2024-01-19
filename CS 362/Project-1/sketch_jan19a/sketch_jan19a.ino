int pinRed = 12;

void setup() {
  // put your setup code here, to run once:
  pinMode(pinRed, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(pinRed, HIGH);
  delay(1000);
  digitalWrite(pinRed, LOW);
  delay(1000);
}
