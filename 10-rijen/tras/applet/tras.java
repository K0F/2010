import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class tras extends PApplet {


PGraphics vignette;

public void setup(){
  size(480,320,P2D);

  frameRate(50);
  rectMode(CENTER);
  noFill();
  stroke(255,220);
  smooth();

  vignette = createGraphics(width+20,height+20,JAVA2D);
  vignette.beginDraw();
  vignette.smooth();
  vignette.noFill();
  vignette.strokeWeight(1.5f);
  for(int i = 0;i<width*2;i++){
    vignette.stroke(0,map(i,0,width*2,0,255));
    vignette.ellipse(vignette.width/2,vignette.height/2,i,i);

  }
  vignette.endDraw();

}


public void draw(){
  //background(0);
  pushStyle();
  fill(0,120);
  rect(width/2,height/2,width,height);
  popStyle();

pushMatrix();
  translate(random(-1,1),random(-1,1));

  for(int i = 0;i<400;i+=2){
    pushMatrix();
    translate(width/2,height/2);
    rotate(frameCount*(1.0f+i/400.0f*noise(frameCount/300.0f)));
    stroke(255,noise((frameCount-i)/30.0f)*220);
    rect(0,0,5+i,5+i);
    popMatrix();
  }
  
  
  popMatrix();
  
  //tint(random(200,255),random(200,255),30,180);
  //tint(255,120);
  image(vignette,random(-20),random(-20));


  //tint(random(200,255),random(200,255),12,150);
  //image(g,random(-2,2),random(-2,2));


  pushStyle();
  strokeWeight(10);
  stroke(0);
   noFill();
   
  rect(width/2,height/2,width,height);
  popStyle();

}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DFDFDF", "tras" });
  }
}
