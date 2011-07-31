import processing.serial.*;
import cc.arduino.*;

boolean listen = true;


Arduino arduino;
float vals[] = new float[8];

float smoothv[] = new float[8];
int  bin [] = {000, 1, 10, 11, 100, 101, 110, 111};
color c[] = {color(255,200,0),color(255,180,0),color(255,160,0),color(255,140,0),
             color(255,120,0),color(255,100,0),color(255,80,0),color(255,60,0)};
int row = 0;
int r0,r1,r2;

void setup() {


	size(1920,300,P2D);

	println(Arduino.list());
	arduino = new Arduino(this, Arduino.list()[0], 57600);

	frameRate(30);


	for (int i = 0; i <= 13; i++)
		arduino.pinMode(i, Arduino.OUTPUT);
	//arduino.pinMode(0,Arduino.INPUT);
	background(0);
}

int cnt=0;
int a = 0;

void draw(){

	//background(0);

	stroke(255);

	for(int i = 0;i<vals.length;i++){
		row = bin[i];
		r0 = row & 0x01;
		r1 = (row>>1) & 0x01;
		r2 = (row>>2) & 0x01;

		if(r0==1){
			arduino.digitalWrite(5,Arduino.HIGH);
		}else{
			arduino.digitalWrite(5,Arduino.LOW);
		}

		if(r1==1){
			arduino.digitalWrite(6,Arduino.HIGH);
		}else{
			arduino.digitalWrite(6,Arduino.LOW);
		}

		if(r2==1){
			arduino.digitalWrite(7,Arduino.HIGH);
		}else{
			arduino.digitalWrite(7,Arduino.LOW);
		}

		delay(5);
		a = arduino.analogRead(1);
		smoothv[i] += (a-smoothv[i])/3.0;

	}

	//arduino.digitalWrite(13,Arduino.HIGH);


	for(int i = 0;i<vals.length;i++){
		stroke(c[i]);
		line(cnt,map(smoothv[i],0,1024,height,0),cnt+1,map(smoothv[i],0,1024,height,0));
	}

	cnt += 1;
	if(cnt>width){
		background(0);
		cnt=0;
	}

	//println(a);


}


