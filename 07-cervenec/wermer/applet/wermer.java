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

public class wermer extends PApplet {


Interpreter brush;
//PImage divka;

public void setup(){
	size(520,640,P2D);
	frameRate(25);
	brush = new Interpreter("wermer.jpg","splat.png",5000);
	//divka = loadImage("wermer.png");
	//divka.filter(GRAY);
	background(0);
	
}


public void draw(){
	noTint();
	image(g,(noise(frameCount)-0.5f)*20.0f,(noise(frameCount*2)-0.5f)*20.0f);
	
	brush.draw();
	
	//image(divka,0,-40,divka.width/1.4,divka.height/1.4);


}

class Interpreter{
	PImage src;
	PImage vzor;
	int c[];
	

	Interpreter(String file, String file2, int num){
		vzor = loadImage(file2);
		src = loadImage(file);
		src.loadPixels();
		//src.filter(GRAY);
		c = new int[num];
		for(int i = 0;i<num;i++){
			c[i] = src.pixels[(int)random(src.pixels.length)];
		}
	}
	
	public void draw(){
		for(int i = 0;i<2;i++){
			pushMatrix();
			
			translate(random(-width,width),random(-height,height));
			pushMatrix();
			float sc=  random(0.12f,3);
			translate(sc*vzor.width/2,sc*vzor.height/2);
			pushMatrix();
			rotate(random(-PI,PI));
			tint(c[(int)random(c.length)],200);
			image(vzor,0,0,vzor.width*sc,vzor.height*sc);
			popMatrix();
			popMatrix();
			popMatrix();
		}
	
	}


}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DFDFDF", "wermer" });
  }
}
