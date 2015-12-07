float timeStart;
float timeStop;

void startTime(){
  timeStart = millis();
}

void stopTime() {
  timeStop = millis();
}

float getTime() {
  float t = round((timeStop - timeStart)/10);
  return t/100;
}

