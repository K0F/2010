



public void init() {
 frame.removeNotify();
 frame.setUndecorated(true);
 frame.setAlwaysOnTop(true);
 
 
 frame.addNotify();
 // call PApplet.init() to take care of business
 super.init();  
} 

int x = 0;

void setup(){
	size(320,240,P2D);
	background(0);
	stroke(255);
	noSmooth();
}

void draw(){
	background(0);
	stroke(255,30);
		
	
	for(int i = 0 ; i< 10 ;i++){
		float shift = random(0,noise(frameCount/50.0)*40.0);
		line(x+shift,0,shift+x,height);
		
	}
	x++;
	x=x%width;

}