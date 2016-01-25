#include "DHT.h"
#define DHTPIN A0 
#define DHTTYPE DHT11
#define SPIN A3
#define LED 13    
#define TVAL 400  
DHT dht(DHTPIN, DHTTYPE);

int count1 = 0;
int count2 = 0;
int count3 = 0;
boolean chk_human = false;
void setup() 
{
  Serial.begin(9600);
  pinMode(LED, OUTPUT);
  dht.begin();
  pinMode(7, INPUT);
  pinMode(8, OUTPUT);
}

void loop() 
{  
  unsigned long times = millis();
  int sval = analogRead(SPIN);
  Serial.print("Sound Value ");
  Serial.println(sval);
  int val = 0;

  
  val = digitalRead(7);
  Serial.print("val=");
  Serial.println(val);
   
  digitalWrite(LED,LOW);
    float h = dht.readHumidity();
    float t = dht.readTemperature();

    // check if returns are valid, if they are NaN (not a number) then something went wrong!
  if (isnan(t) || isnan(h)) 
  {
    Serial.println("Failed to read from DHT");
  } 
  else 
  {
    Serial.print("Humidity "); 
    Serial.println(h);
    Serial.print("Temperature "); 
    Serial.println(t);
  }


//    if(millis() % 60000 != 0){
  //音センサー判定
    if(450 < sval ){ 
      count1 ++;
      Serial.println(count1);
    }
    if(count1 == 10){
      Serial.println("Sound:High");
    } 

//温度、湿度センサー判定
//湿度
    if(h<40 || h > 60){ 
      count2 ++;
      Serial.println(count2);
    }
    if(count2 == 30){
      Serial.println("Humidity:High");
    }

//温度
    if(19 > t || t > 27){ 
      count3 ++;
      Serial.println(count3);
    }
    if(count3 == 30){
      Serial.println("Temperature:High");
    }

//人感センサー
    if(val == 0 && chk_human == false){
      chk_human = true;
      Serial.println("Zinkan:High");
      digitalWrite(8,HIGH);
    } else if(val != 0){
      chk_human = true;
    }

//    delay(1000);
  
//１分経った場合countを初期化
    if(millis() % 6000 == 0){
      count1 = 0;
      count2 = 0;
      count3 = 0;
    }
  delay(1000);
//  }
}
