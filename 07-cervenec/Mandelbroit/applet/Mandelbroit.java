import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Mandelbroit extends PApplet {


PImage monsieur,monsieurFiltered;

float xmin = -1.5f;
float ymin = -2.5f;
float wh = 40;
float ZOOM = -0.2f;

public void setup() {
	size(320, 320, P2D);
	monsieur = loadImage("mb.png");
	//PImage msk = mb;
	monsieurFiltered = monsieur;
	monsieurFiltered.filter(THRESHOLD,0.7f);
	//mb.mask(mb);
	loadPixels();
}

public void draw() {
	
	
	
	tint(-1);
	image(g,0,0.1f);
	
	

	wh = 8;

	xmin = map(height/3*2,0,height,0,-wh);
	ymin = map(width/2,0,width,0,-wh);

	float mod1 = noise(frameCount/50.0f)+0.001f;
	float mod2 = noise(232+frameCount/353.0f)+0.001f;
	float mod3 = noise(12323+frameCount/355.0f)+0.001f;
	float mod4 = noise(-10239+frameCount/30.0f)+0.001f;
	
	
	
	
	
	//noTint();
	tint(255,60);
	pushMatrix();
	//scale(mod1*mod2*mod3*mod4);
	image(monsieurFiltered,mod1*500*ZOOM,mod1*500*ZOOM,width-mod1*1000*ZOOM,height-mod1*1000*ZOOM);

	popMatrix();
	int maxiterations = 20;

	float xmax = xmin + wh;
	float ymax = ymin + wh;

	float dx = (xmax - xmin) / (width);
	float dy = (ymax - ymin) / (height);

	// Start y
	float y = ymin;
	for (int j = 0; j < height; j++) {
		// Start x
		float x = xmin;
		for (int i = 0;  i < width; i++) {

			float a = x;
			float b = y;
			int n = 0;
			while (n < maxiterations) {
				float aa = a * a * mod3;
				float bb = b * b * mod2;
				float twoab = 2.0f * a * b * mod1;
				a = aa - bb + x * mod2;
				b = twoab + y * mod4;
				if(aa + bb > 16) {
					break;  
				}
				n++;
			}

			if (n == maxiterations) {
				//pixels[j+i*width] = color(255);
				
			} else {
				pixels[j+i*width] = lerpColor(color(n*10 % 255),pixels[j+i*width],0.12f);
			}
			x += dx;
		}
		y += dy;
	}
	updatePixels();
	

}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DFDFDF", "Mandelbroit" });
  }
}
