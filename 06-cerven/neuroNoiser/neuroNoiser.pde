import codeanticode.gsvideo.*;

Neuron n[][] = new Neuron[240][320];
import krister.Ess.*;
GSPipeline cam;
AudioStream myStream;
float[] streamBuffer;
int y  = 0;

float bluramount = 0.5;

void setup(){
	size(n[0].length,n.length,P3D);
	background(0);

	frameRate(25);

	noSmooth();

	Ess.start(this);

	myStream=new AudioStream();
	myStream.sampleRate(44100/4);
	myStream.bufferSize(width);
	streamBuffer=new float[myStream.size];
	myStream.start();


	for(int i =0;i<n.length;i++){
		for(int ii =0;ii<n[i].length;ii++){
			n[i][ii] = new Neuron(i,ii);
		}
	}

	noFill();


	
	String webcam = "v4l2src ! queue2 ! ffvideoscale ! "+"video/x-raw-rgb,width="+width+",height="+height+", bpp=32, depth=24";
	cam = new GSPipeline(this, webcam);


}

void keyPressed()
{
	if(keyCode==UP){
		bluramount+=0.1;
	}else if(keyCode==DOWN){
		bluramount-=0.1;
	}

	bluramount=constrain(bluramount,0.5,40);

}


void fillAudioBufferL(){
	
	loadPixels();

	
	int cnt =0;
	for(int X=0; X<width; X++) {
		streamBuffer[X] = map(brightness(pixels[y*width+X]),0,255,-0.9,0.9)+sin(noise(frameCount/2.0)*255);
		cnt++;
	}
	/*
	for(int X=width-1; X>=0; X--) {
		streamBuffer[X] = map(brightness(pixels[y*width+X]),0,255,-0.9,0.9);
		cnt++;
}*/

	//y=(int)((sin(frameCount/30.0)+1.0)*height/2.0);// width/3;//mouseY;
	y=height/2;//y%height;

}

void fillAudioBuffer(){
	loadPixels();


	for(int Y=0; Y<height; Y++) {
		if(Y%2==0){
			for(int X=0; X<width; X++) {

				streamBuffer[Y*width+X] = map(brightness(pixels[Y*width+X]),0,255,-0.9,0.9);
			}

		}else{
			for(int X=width-1; X>=0; X--) {

				streamBuffer[Y*width+X] = map(brightness(pixels[Y*width+X]),0,255,-0.9,0.9);
			}
		}
	}



	//myLowPass=new LowPass(220,-80,4);

	//myLowPass.filter(myStream);
}
void audioStreamWrite(AudioStream theStream) {
	System.arraycopy(streamBuffer,0,myStream.buffer,0,streamBuffer.length);
}

void draw(){
	//background(0);

	for(int i =0;i<n.length;i++){
		for(int ii =0;ii<n[i].length;ii++){
			n[i][ii].cycle();
		}
	}


	for(int i =0;i<n.length;i++){
		for(int ii =0;ii<n[i].length;ii++){
			n[i][ii].update();
		}
	}


	for(int i =0;i<n.length;i++){
		for(int ii =0;ii<n[i].length;ii++){
			pushMatrix();
			translate(ii,i);
			n[i][ii].draw();
			popMatrix();
		}
	}

	if(bluramount>0.5)
		filter(BLUR,bluramount);

	fillAudioBufferL();
	
	if (cam.available() == true){
		cam.read();
		cam.loadPixels();
		for(int i =0;i<pixels.length;i++)
		pixels[i]=color(brightness(cam.pixels[i]+pixels[i])/2.0);
	}
	
	
	stroke(255,0,0);
	//line(0,y,width,y);




}

public void stop() {
	Ess.stop();
	super.stop();
}


class Neuron{

	int lay,id;
	float vibra,val,val2;
	//float tresh = 240.0;
	//float prum[] = new float[3];

	float tone = 0,amount = 0;
	float[] w;

	Neuron(int _lay,int _id){
		lay = _lay;
		id = _id;
		w = new float[8];
		for(int i =0;i<w.length;i++){
			w[i] = random(400)/100.0;
		}
		vibra = random(800,1000)/10000.0;


		val = random(255);

	}

	void cycle(){

		tone+=vibra;
		amount = (sin(tone)+1.0)/2.0;

		val2 = 0.0;



		val2 += n[(lay+n.length-1)%n.length][(id+n[0].length-1)%n[0].length].val*amount*w[0];
		val2 += n[(lay+n.length-0)%n.length][(id+n[0].length-1)%n[0].length].val*amount*w[1];
		val2 += n[(lay+n.length+1)%n.length][(id+n[0].length-1)%n[0].length].val*amount*w[2];

		//val2 += n[(lay+n.length)%n.length][(id+n[0].length-1)%n[0].length].val*amount*w[2];
		//val2 += n[(lay+n.length)%n.length][(id+n[0].length+1)%n[0].length].val*amount*w[3];

		/*

				float Rprum = 0.0;
				prum[(frameCount)%prum.length] = val;
				for(int i = 0;i<prum.length;i++){
					Rprum += prum[i];
				}
				Rprum/=prum.length;

				if(Rprum>=tresh){
					assimilate(0.01,0.00,0.001);
					//val = 1;

					//n[(lay+n.length-1)%n.length][(id+n[0].length-1)%n[0].length].val = 255-val;
				}

		*/
		val2 /= (3.0);
		
		if(val<50||val>200)
		stochaist(470.0);


	}
	/*
		void assimilate(float kolik,float kolik2,float kolik3){

			-1,-1 0,-1 1,-1
			-1,0 x,x 1,0
			-1,1 0,1 1,1

			

			// synchronize to vibra val
			n[(lay+n.length-1)%n.length][(id+n[0].length-1)%n[0].length].vibra += (vibra-n[(lay+n.length-1)%n.length][(id+n[0].length-1)%n[0].length].vibra)*kolik;
			n[(lay+n.length-1)%n.length][(id+n[0].length)%n[0].length].vibra += (vibra-n[(lay+n.length-1)%n.length][(id+n[0].length)%n[0].length].vibra)*kolik;
			n[(lay+n.length-1)%n.length][(id+n[0].length+1)%n[0].length].vibra += (vibra-n[(lay+n.length-1)%n.length][(id+n[0].length+1)%n[0].length].vibra)*kolik;

			n[lay][(id+n[0].length-1)%n[0].length].vibra += (vibra-n[lay][(id+n[0].length-1)%n[0].length].vibra)*kolik;
			n[lay][(id+n[0].length+1)%n[0].length].vibra += (vibra-n[lay][(id+n[0].length+1)%n[0].length].vibra)*kolik;

			n[(lay+n.length+1)%n.length][(id+n[0].length-1)%n[0].length].vibra += (vibra-n[(lay+n.length+1)%n.length][(id+n[0].length-1)%n[0].length].vibra)*kolik;
			n[(lay+n.length+1)%n.length][(id+n[0].length)%n[0].length].vibra += (vibra-n[(lay+n.length+1)%n.length][(id+n[0].length)%n[0].length].vibra)*kolik;
			n[(lay+n.length+1)%n.length][(id+n[0].length+1)%n[0].length].vibra += (vibra-n[(lay+n.length+1)%n.length][(id+n[0].length+1)%n[0].length].vibra)*kolik;



			// approx. counter weights
			n[(lay+n.length-1)%n.length][(id+n[0].length-1)%n[0].length].w[7] += (w[0]-n[(lay+n.length-1)%n.length][(id+n[0].length-1)%n[0].length].w[7])*kolik2;
			n[(lay+n.length-1)%n.length][(id+n[0].length)%n[0].length].w[6] += (w[1]-n[(lay+n.length-1)%n.length][(id+n[0].length)%n[0].length].w[6])*kolik2;
			n[(lay+n.length-1)%n.length][(id+n[0].length+1)%n[0].length].w[5] += (w[2]-n[(lay+n.length-1)%n.length][(id+n[0].length+1)%n[0].length].w[5])*kolik2;

			n[lay][(id+n[0].length-1)%n[0].length].w[4] += (w[3]-n[lay][(id+n[0].length-1)%n[0].length].w[4])*kolik2;
			n[lay][(id+n[0].length+1)%n[0].length].w[3] += (w[4]-n[lay][(id+n[0].length+1)%n[0].length].w[5])*kolik2;

			n[(lay+n.length+1)%n.length][(id+n[0].length-1)%n[2].length].w[2] += (w[5]-n[(lay+n.length+1)%n.length][(id+n[0].length-1)%n[0].length].w[2])*kolik2;
			n[(lay+n.length+1)%n.length][(id+n[0].length)%n[1].length].w[1] += (w[6]-n[(lay+n.length+1)%n.length][(id+n[0].length)%n[0].length].w[1])*kolik2;
			n[(lay+n.length+1)%n.length][(id+n[0].length+1)%n[0].length].w[0] += (w[7]-n[(lay+n.length+1)%n.length][(id+n[0].length+1)%n[0].length].w[0])*kolik2;


			// (experimental) approx. tones
			n[(lay+n.length-1)%n.length][(id+n[0].length-1)%n[0].length].w[0] += (w[7]-n[(lay+n.length-1)%n.length][(id+n[0].length-1)%n[0].length].tone)*kolik3;
			n[(lay+n.length-1)%n.length][(id+n[0].length)%n[0].length].w[1] += (w[6]-n[(lay+n.length-1)%n.length][(id+n[0].length)%n[0].length].tone)*kolik3;
			n[(lay+n.length-1)%n.length][(id+n[0].length+1)%n[0].length].w[2] += (w[5]-n[(lay+n.length-1)%n.length][(id+n[0].length+1)%n[0].length].tone)*kolik3;

			n[lay][(id+n[0].length-1)%n[0].length].w[3] += (w[4]-n[lay][(id+n[0].length-1)%n[0].length].tone)*kolik3;
			n[lay][(id+n[0].length+1)%n[0].length].w[4] += (w[3]-n[lay][(id+n[0].length+1)%n[0].length].tone)*kolik3;

			n[(lay+n.length+1)%n.length][(id+n[0].length-1)%n[0].length].tone += (tone-n[(lay+n.length+1)%n.length][(id+n[0].length-1)%n[0].length].tone)*kolik3;
			n[(lay+n.length+1)%n.length][(id+n[0].length)%n[0].length].tone += (tone-n[(lay+n.length+1)%n.length][(id+n[0].length)%n[0].length].tone)*kolik3;
			n[(lay+n.length+1)%n.length][(id+n[0].length+1)%n[0].length].tone += (tone-n[(lay+n.length+1)%n.length][(id+n[0].length+1)%n[0].length].tone)*kolik3;
		}
	*/
	void update(){
		val += (val2-val)/1.0;
		val = constrain(val,1,254);
	}

	void draw(){
		stroke(noise(frameCount/20.0)*255+val);//lerpColor(#000000,#f7fd58,val/(255.0)),30.0);
		point(0,0);


	}

	void sync(float kolik){
		n[(lay+n.length+1)%n.length][id].amount += (amount-n[(lay+n.length+1)%n.length][id].amount)*(map(val,0,255,0,kolik));
		n[(lay+n.length+1)%n.length][id].vibra += (vibra-n[(lay+n.length+1)%n.length][id].vibra)*(map(val,0,255,0,kolik));
		n[(lay+n.length+1)%n.length][id].tone += (tone-n[(lay+n.length+1)%n.length][id].tone)*(map(val,0,255,0,kolik));


	}

	void stochaist(float kolik){
		for(int i =0;i<w.length;i++){
			w[i]+=random(-kolik,kolik)/1000.0;
			//vibra+=random(-kolik,kolik)/1000.0;
			w[i] = constrain(w[i],0.01,5.0);
		}
	}




}
