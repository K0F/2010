import processing.net.*;
Client myClient;
int dataIn;

String data;

void setup() {
	size(800, 600,P2D);
	background(50);
	
	//c = new Client(this, "http://www.volbyhned.cz", 80);
	myClient = new Client(this, "194.228.52.94", 80);


	textFont(createFont("Veranda",12,true));
	textMode(SCREEN);
	fill(255);
}


void draw() {
	
	if (myClient.available() > 0) { // If there's incoming data from the client...
		data = myClient.readString(); // ...then grab it and print it
		println(data);
		text(data,10,10);
		myClient.clear();

	}
}

void refresh(){

	//try{

		myClient.write("GET ps2010/ps_celk.html \n"); // Use the HTTP "GET" command to ask for a Web page
		myClient.write("Host: datagrabber.cz\n\n"); // Be polite and say who we are

	//}catch(Exception e){
	//	println(e);

	//}

}

void keyPressed(){

	refresh();

}
