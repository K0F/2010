

// Example by Tom Igoe

import processing.serial.*;

// The serial port:
Serial myPort;

int lf = 10;

void setup(){
	// List all the available serial ports:
	println(Serial.list());

	size(200,200,P2D);
	/*  I know that the first port in the serial list on my mac
	is always my  Keyspan adaptor, so I open Serial.list()[0].
	Open whatever port is the one you're using.
	*/                                  
	myPort = new Serial(this, Serial.list()[0], 115200);

	// Send a capital A out the serial port:
	myPort.write(65);
	stroke(255);
}

float sm[] = new float[8];
float m[] = new float[8];
byte[] q;
void draw(){
	background(0);

	while (myPort.available() > 0) {
		q = myPort.readBytesUntil('\n');



		/*
		if(a!=null){
			//sm[] = parseInt(a.substring(1,a.length()));		
			String parse = (parseInt(a.charAt(0))-48)+" "+a.substring(3,a.length());
			//if(!parse.equals("\r")){
			//String tmp[] = splitTokens(parse," ");
			//m[parseInt(tmp[0])] = parseInt(tmp[1]);
		//	println(parse);
			}
	}*/

		//println(a);
	}

	String msg = "";
	
	if(q!=null)
		for(int i = 0;i<q.length;i++){
		//	msg = "";
			//if(i!=1&&i!=2)
			msg += char(q[i])+"";
		
			if(i==0)
				msg += " ";
		}
		
		String parse[] = splitTokens(msg," ");
		//println(parse[0]+":"+parse[1]);


	for(int i = 0;i<sm.length;i++){
		line(0,map(sm[i],0,1024,height,0),width,map(sm[i],0,1024,height,0));
	}




}

