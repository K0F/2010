import processing.serial.*;

XBee xbee;

XBee xbee2;

String one,two;


void setup(){

	size(200,120,P2D);
	frameRate(30);
	println(Serial.list());

	one = Serial.list()[1];
	//two = Serial.list()[0];
	
	xbee = new XBee(this,one);
	//xbee2 = new XBee(this,two);

}

void draw(){
	background(0);
	
	xbee.signal();

}

void keyReleased(){

	if(key==' '){


		xbee.setMode();

	}else if(key=='a'){

		xbee.getAddress();
	}else if(key=='d'){
		println("detekuji ostatni XBee.. ");
		xbee.detect();
	}else if(key=='s'){
		xbee.setup(3333,3334);	
	}else if(key=='r'){
		xbee.reset();	
	}

}


void serialEvent (Serial myPort) {
	String inString = myPort.readStringUntil('\r');

	if (inString != null) {

		println("XBee response: "+inString);
	}

}

class XBee{

	Serial port;
	boolean emit = true;

	XBee(PApplet _parent,String _portName){

		port = new Serial(_parent, _portName, 9600);
		port.clear();

		//myPort.bufferUntil('\n');
		
		
		

	}

	void setup(int loc, int dest){
		
		
		/*
		println("nastavuji XBee dest add na: "+dest);
		port.write("ATDL"+dest+"\r"); // Set XBee destination address
		println("nastavuji XBee local add na: "+loc);
		port.write("ATMY"+loc+"\r"); // Set XBee address
		println("ukladam zmeny.. ");
		port.write("ATWR\r"); // Save changes to XBee
		println("XBee zpet na data mode!");
		*/
		
		//listener settings		
		port.write("ATID1111,");
		port.write("MY1,");
		port.write("DH0,");
		port.write("DL2,");
		//port.write("IA1");
		port.write("CN\r");
		
		//port.write("ATCN\r"); // Return XBee to data mode
		
		//emit = true;

	}
	
	void reset(){
		println("resseting XBee ...");
		port.write("ATRE,");
		port.write("WR,");
		port.write("CN\r");
	
	}

	void setMode(){
		println("nastavuji XBee do program modu.. ");
		port.write("X");
		delay(1100);
		
		port.write("+++");
		delay(1100);
		
		

	}

	void getAddress(){
		println("ziskavam XBee adresu.. ");
		port.write("ATID\r");

	}

	void detect(){
		port.write("ATND\r");

	}
	
	void signal(){
		if(emit){
		
		delay(100);
	xbee.port.write("I\r");
	
	delay(100);
	xbee.port.write("O\r");
		
		}
	}

	//serial.write("ATDH"+destinationHigh+", DL"+destinationLow+"\r");
	//serial.write("ATMY"+myAddress+"\r");
	//serial.write("ATID"+panId+"\r");
	//serial.write("ATCN\r");


}
