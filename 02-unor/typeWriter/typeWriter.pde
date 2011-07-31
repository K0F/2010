import promidi.*;

MidiIO midiIO;
MidiOut midiOut;


//int notes[][] = {{60},{62},{64},{65},{67},{69},{71},{72,4.0}};

int lo = 50,hi = 380;


String[] txt = new String[0];
int ln = 0;

PGraphics effect;

void setup(){

	size(1600,900,P2D);
	
	frameRate(30);
	
	midiIO = MidiIO.getInstance(this);
	println("printPorts of midiIO");
	midiIO.printDevices();
	println();

	println("printDevices recoded 1");
	midiIO.printInputDevices();
	midiIO.printOutputDevices();
	println("<<<<<<<<<   >>>>>>>>>>>>>>>>>>>>>");
	println();

    //println(PFont.list());

	textFont(createFont("Liberation Sans",12,false));
	textMode(SCREEN);

	effect = createGraphics(128,128,P2D);
	
	
	/*
	 * Does the same like printDevices by iterating
	 * over the devices and print out their names
	 
	println("printDevices recoded 2");
	println("<< inputs: >>>>>>>>>>>>>>>>>>>>>>");
	for(int i = 0; i < midiIO.numberOfInputDevices();i++){
		println("input  "+nf(i,2)+": "+midiIO.getInputDeviceName(i));
}
	println("<< outputs: >>>>>>>>>>>>>>>>>>>>>");
	for(int i = 0; i < midiIO.numberOfOutputDevices();i++){
		println("output "+nf(i,2)+": "+midiIO.getOutputDeviceName(i));
}
	println("<<<<<<<<<   >>>>>>>>>>>>>>>>>>>>>");

	 */

	initMidi();
	txt = (String[])expand(txt,txt.length+1);
	txt[txt.length-1] = " ";






}

void draw(){
	background(0);

	fill(255);
	
	


	for(int i = 0;i<=ln;i++)
		text(txt[i],20,i*12+20);

	fill((sin(frameCount/3.0)+1)*127);
	text("_");


}

void makeEffect(char input){



}


boolean samohlaska(){
	if(key == 97 ||key == 101 ||key == 105 ||key == 111 ||key == 117 ||
	        key == 105 ||key == 283 ||key == 253 ||key == 225 ||key == 237 ||
	        key == 233 ||key == 250 ||key == 367){
		return true;
	}else{
		return false;
	}

}

void keyPressed(){

	if(keyCode == BACKSPACE){
		if(txt[ln].length()>=2)
			txt[ln] = txt[ln].substring(0,txt[ln].length()-1);


		try{
			Note test = new Note(100, 127, (int)random(400));
			midiOut.sendNote(test);
		}catch(java.lang.NullPointerException e){
			println("moc not najednou!");
		}


	}else if(keyCode == ENTER){
		txt = (String[])expand(txt,txt.length+1);
		txt[txt.length-1] = " ";
		ln++;

	}else if( samohlaska() ){


		float tone = 10;

		char tmp = (char)key;

		switch (tmp){

		case 'a': tone = 64; break;
		case 'e': tone = 66; break;
		case 'i': tone = 68; break;
		case 'o': tone = 70; break;
		case 'u': tone = 72; break;
		case 'y': tone = 74; break;

		case 'á': tone =65; break;
		case 'é': tone =67; break;
		case 'í': tone =69; break;
		case 'ó': tone =71; break;
		case 'ú': tone =73; break;
		case 'ý': tone =75; break;

		case 'ů': tone =73; break;

		case 'A': tone = 64/2; break;
		case 'E': tone = 66/2; break;
		case 'I': tone = 68/2; break;
		case 'O': tone = 70/2; break;
		case 'U': tone = 72/2; break;
		case 'Y': tone = 74/2; break;

		}

		txt[ln] += (char)key;




		try{
			Note test = new Note( (int)(((tone) )%127), 127, (int)random(400));
			midiOut.sendNote(test);
		}catch(java.lang.NullPointerException e){
			println("moc not najednou!");
		}

	}else if(key < 400){


		float tone = 10;

		char tmp = (char)key;

		switch (tmp){

		case 'b': tone = 32; break;
		case 'c': tone = 34; break;
		case 'd': tone = 36; break;
		case 'f': tone = 38; break;
		case 'g': tone = 40; break;
		case 'h': tone = 42; break;
		case 'j': tone = 44; break;
		case 'k': tone = 46; break;
		case 'l': tone = 48; break;
		case 'm': tone = 50; break;
		case 'n': tone = 52; break;
		case 'p': tone = 54; break;
		case 'q': tone = 56; break;
		case 'r': tone = 58; break;
		case 's': tone = 60; break;
		case 't': tone = 62; break;
		case 'v': tone = 64; break;
		case 'w': tone = 66; break;
		case 'x': tone = 68; break;
		case 'z': tone = 70; break;

		case 'š': tone =60*2; break;
		case 'č': tone =62*2; break;
		case 'ř': tone=  64*2; break;
		case 'ž': tone=  66*2; break;
		         
		case '0': tone = 72; break;
		case '1': tone = 74; break;
		case '2': tone = 76; break;
		case '3': tone = 78; break;
		case '4': tone = 80; break;
		case '5': tone = 82; break;
		case '6': tone = 84; break;
		case '7': tone = 86; break;
		case '8': tone = 88; break;
		case '9': tone = 90; break;   
		          
		


		}

		txt[ln] += (char)key;




		try{
			Note test = new Note( (int)((tone)%127), 127, (int)random(400));
			midiOut.sendNote(test);
		}catch(java.lang.NullPointerException e){
			println("moc not najednou!");
		}
	}
}


void initMidi(){
	midiIO = MidiIO.getInstance(this);
	//idiOut = MidiIO.getMidiOut(0,0);
	midiOut = midiIO.getMidiOut(0,1);



}








